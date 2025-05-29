import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/plots/model/entities/activity_entity.dart';
import 'package:huertix_project/features/plots/model/entities/participation_entity.dart';

abstract class ActivityRepository {
  Future<Either<Failure, void>> createActivity(String plotId, String responsibleId, String name, String type, DateTime dateTimePlanned);
  Future<Either<Failure, ActivityEntity>> getActivityById(String id);
  Future<Either<Failure, List<ActivityEntity>>> getAllActivities();
  Future<Either<Failure, List<ActivityEntity>>> getActivitiesByPlotId(String plotId);
  Future<Either<Failure, List<ActivityEntity>>> getActivitiesByVolunteerId(String volunteerId);
  Future<Either<Failure, void>> updateActivity(ActivityEntity activity);

  Future<Either<Failure, void>> registerParticipation(String activityId, String volunteerId, double timeEstimated, double timeSpent);
  Future<Either<Failure, ParticipationEntity>> getParticipationById(String id);
  Future<Either<Failure, List<ParticipationEntity>>> getParticipationsByUserId(String userId);
}