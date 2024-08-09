abstract class DetailWorkoutEvent {}

class LoadDetailWorkoutEvent extends DetailWorkoutEvent {
  final int id;

  LoadDetailWorkoutEvent(this.id);
}
