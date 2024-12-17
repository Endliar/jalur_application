import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:jalur/models/coach.dart';
import 'package:jalur/response_api/get_coach_data.dart';

import '../../adapters/coach_adapter.dart';
import 'coach_workout_event.dart';
import 'coach_workout_state.dart';

class CoachDataBloc extends Bloc<CoachDataEvent, CoachDataState> {
  final GetCoachData getCoachData;

  CoachDataBloc(this.getCoachData) : super(InitialState()) {
    on<LoadCoachDataEvent>(_onLoadCoachDataEvent);
    on<CoachDetailButtonPressed>(_onCoachDetailButtonPressed);
  }

  Future<void> _onLoadCoachDataEvent(
      LoadCoachDataEvent event, Emitter<CoachDataState> emit) async {
    emit(LoadingCoachDataState());
    try {
      final Box<CoachAdapter> coachBox = Hive.box<CoachAdapter>('coaches');
      final List<Coach> cachedCoaches =
          coachBox.values.map((adapter) => adapter.toCoach()).toList();

      if (cachedCoaches.isNotEmpty) {
        emit(LoadCoachDataSuccess(cachedCoaches));
        print("Cached coaches loaded");
      }

      final List<Coach> serverCoaches = await getCoachData.getCoachesData();

      if (cachedCoaches.isEmpty ||
          await _isCacheOutdated(cachedCoaches, serverCoaches)) {
        await _updateCache(serverCoaches);
        emit(LoadCoachDataSuccess(serverCoaches));
      }
    } catch (e) {
      emit(CoachErrorState(e.toString()));
    }
  }

  Future<void> _onCoachDetailButtonPressed(
      CoachDetailButtonPressed event, Emitter<CoachDataState> emit) async {
    emit(LoadingCoachDataState());
    try {
      final Coach coach = await getCoachData.getUserData(event.coachId);
      emit(LoadCoachDataSuccess([coach]));
    } catch (e) {
      emit(CoachErrorState(e.toString()));
    }
  }

  Future<bool> _isCacheOutdated(
      List<Coach> cachedCoaches, List<Coach> serverCoaches) async {
    final Map<int, Coach> cachedCoachMap = {
      for (var coach in cachedCoaches) coach.id: coach
    };

    for (var serverCoach in serverCoaches) {
      final cachedCoach = cachedCoachMap[serverCoach.id];
      if (cachedCoach == null ||
          cachedCoach.updatedAt != serverCoach.updatedAt) {
        // Если дата обновления отличается, кэш устарел
        return true;
      }
    }
    // Все тренеры актуальны
    return false;
  }

  Future<void> _updateCache(List<Coach> coaches) async {
    final Box<CoachAdapter> coachBox = Hive.box<CoachAdapter>('coaches');
    await coachBox.clear();
    await coachBox
        .addAll(coaches.map((coach) => CoachAdapter.fromCoach(coach)));
  }
}
