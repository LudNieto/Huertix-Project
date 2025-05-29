import 'package:equatable/equatable.dart';

class ParticipationEntity extends Equatable {
  final String id;
  final String idActivity;
  final String idVolunteer;
  final double timeEstimated;
  final double timeSpent;


  const ParticipationEntity({
    required this.id,
    required this.idActivity,
    required this.idVolunteer,
    required this.timeEstimated,
    required this.timeSpent,
  });

  @override
  List<Object?> get props => [
    id,
    idActivity,
    idVolunteer,
    timeEstimated,
    timeSpent,
  ];
}
