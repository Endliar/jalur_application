import 'package:equatable/equatable.dart';

class RecoilEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecoilCreateEvent extends RecoilEvent {
  final int id;
  final int userId;
  final int recoilTraining;
  final String scheduleDay;

  RecoilCreateEvent(
      {required this.id,
      required this.userId,
      required this.recoilTraining,
      required this.scheduleDay});

  @override
  List<Object> get props => [id, userId, recoilTraining, scheduleDay];
}
