abstract class CoachDataEvent {}

class LoadCoachDataEvent extends CoachDataEvent {}

class CoachDetailButtonPressed extends CoachDataEvent {
  final int coachId;

  CoachDetailButtonPressed({required this.coachId});
}
