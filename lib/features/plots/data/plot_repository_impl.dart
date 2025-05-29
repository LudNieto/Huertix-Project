import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/auth/data/firebase_auth_datasource.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/plots/data/plot_model.dart';
import 'package:huertix_project/features/plots/model/entities/plot_entity.dart';
import 'package:huertix_project/features/plots/model/repositories/plot_repository.dart';

class PlotRepositoryImpl implements PlotRepository {
  final FirebaseFirestore firestore;

  PlotRepositoryImpl({required this.firestore});
  CollectionReference get _plotsCollection => firestore.collection('plots');
  CollectionReference get _usersCollection => firestore.collection('users');

  @override
  Future<Either<Failure, void>> createPlot(PlotEntity plot) async{
    try {
      final plotModel = PlotModel(
        id: '',
        name: plot.name,
        location: plot.location,
        size: plot.size,
        currentCrops: plot.currentCrops,
        status: plot.status,
        createdAt: plot.createdAt,
        maxVolunteers: plot.maxVolunteers,
      );
      await _plotsCollection.add(plotModel.toFirestoreMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error de Firebase al crear parcela.'));
    } catch (e) {
      return Left(ServerFailure('Error inesperado al crear parcela: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> acceptApplication(
    String plotId,
    String volunteerId,
  ) {
    // TODO: implement acceptApplication
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> applyToPlot(String plotId, String userId) {
    // TODO: implement applyToPlot
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PlotEntity>>> getAllPlots() {
    // TODO: implement getAllPlots
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getPlotApplicants(String plotId) {
    // TODO: implement getPlotApplicants
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PlotEntity>> getPlotById(String id) {
    // TODO: implement getPlotById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getPlotVolunteers(String plotId) {
    // TODO: implement getPlotVolunteers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeAplicant(String plotId, String userId) {
    // TODO: implement removeAplicant
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeVolunteer(String plotId, String userId) {
    // TODO: implement removeVolunteer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePlot(PlotEntity plot) {
    // TODO: implement updatePlot
    throw UnimplementedError();
  }
}
