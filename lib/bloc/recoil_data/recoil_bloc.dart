import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/recoil_data/recoil_event.dart';
import 'package:jalur/bloc/recoil_data/recoil_state.dart';
import 'package:jalur/response_api/create_recoil_record.dart';

class RecoilBloc extends Bloc<RecoilEvent, RecoilState> {
  RecoilBloc() : super(RecoilInitialState()) {
    on<RecoilCreateEvent>(_onCreateEvent);
  }
}

Future<void> _onCreateEvent(
  RecoilCreateEvent event,
  Emitter<RecoilState> emit,
) async {
  emit(RecoilLoadingState());
  try {
    await createRecoilRecord(
        event.id, event.userId, event.recoilTraining, event.scheduleDay);
    emit(RecoilSuccessState());
  } catch (e) {
    emit(RecoilErrorState('An error occurred: $e'));
  }
}
