import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/plots/model/entities/plot_entity.dart';

abstract class PlotRepository {
  Future<Either<Failure, void>> createPlot(PlotEntity plot);
  Future<Either<Failure, void>> updatePlot(PlotEntity plot);
  Future<Either<Failure, void>> acceptApplication(String plotId, String volunteerId);

  Future<Either<Failure, void>> applyToPlot(String plotId, String userId);
  Future<Either<Failure, void>> removeVolunteer(String plotId, String userId);
  Future<Either<Failure, void>> removeAplicant(String plotId, String userId);

  Future<Either<Failure, List<PlotEntity>>> getAllPlots();
  Future<Either<Failure, PlotEntity>> getPlotById(String id);
  Future<Either<Failure, List<UserEntity>>> getPlotApplicants(String plotId);
  Future<Either<Failure, List<UserEntity>>> getPlotVolunteers(String plotId);

}