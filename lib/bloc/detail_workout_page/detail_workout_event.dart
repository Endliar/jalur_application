abstract class DetailWorkoutEvent {}

class LoadWorkoutEvent extends DetailWorkoutEvent {
  final int id;

  LoadWorkoutEvent(this.id);
}
