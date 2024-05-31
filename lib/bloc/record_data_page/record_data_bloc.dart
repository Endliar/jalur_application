import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalur/bloc/record_data_page/record_data_event.dart';
import 'package:jalur/bloc/record_data_page/record_data_state.dart';
import 'package:jalur/response_api/get_record.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordDataBloc extends Bloc<RecordDataEvent, RecordDataState> {
  final GetRecordApi getRecordApi;

  RecordDataBloc({required this.getRecordApi}) : super(InitialState()) {
    on<LoadRecordDataEvent>(_onLoadRecordDataEvent);
  }

  Future<void> _onLoadRecordDataEvent(
      LoadRecordDataEvent event, Emitter<RecordDataState> emit) async {
    emit(LoadingRecordDataState());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      if (userId != null) {
        final records = await getRecordApi.getUserRecords(userId!);
        emit(LoadRecordDataSuccess(records));
      } else {
        emit(RecordErrorState('User ID not found'));
      }
    } catch (e) {
      emit(RecordErrorState(e.toString()));
    }
  }
}
