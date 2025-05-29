import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/plots/model/entities/plot_entity.dart';

abstract class PlotRepository {
  Future<Either<Failure, void>> createPlot(String name, String location, String size, String currentCrops, String status, int maxVolunteers);
  Future<Either<Failure, PlotEntity>> getPlotById(String id);
  Future<Either<Failure, List<PlotEntity>>> getAllPlots();
  Future<Either<Failure, void>> updatePlot(PlotEntity plot);
  Future<Either<Failure, void>> registerVolunteerToPlot(String plotId, String volunteerId);
}