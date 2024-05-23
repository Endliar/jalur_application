import '../../models/record.dart';

abstract class RecordDataState {}

class InitialState extends RecordDataState {}

class LoadingRecordDataState extends RecordDataState {}

class LoadRecordDataSuccess extends RecordDataState {
  final List<Record> records;

  LoadRecordDataSuccess(this.records);
}

class RecordErrorState extends RecordDataState {
  final String error;
  RecordErrorState(this.error);
}

class GetRecordSuccessState extends RecordDataState {}

class GetRecordFailureState extends RecordDataState {
  final String error;

  GetRecordFailureState(this.error);
}
