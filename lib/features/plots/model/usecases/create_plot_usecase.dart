import 'package:dartz/dartz.dart';
import 'package:huertix_project/features/core/error.dart';
import 'package:huertix_project/features/core/usecase.dart';
import 'package:huertix_project/features/plots/model/entities/plot_entity.dart';
import 'package:huertix_project/features/plots/model/repositories/plot_repository.dart';

class CreatePlotUseCase implements UseCase<void, CreatePlotParams> {
  final PlotRepository plotRepository;

  CreatePlotUseCase(this.plotRepository);

  @override
  Future<Either<Failure, void>> call(CreatePlotParams params) async{
    return await plotRepository.createPlot(
      PlotEntity(
        id: '',
        name: params.name,
        location: params.location,
        size: params.size,
        currentCrops: params.currentCrops,
        status: PlotStatusEnum.disponible,
        createdAt: DateTime.now(),
        maxVolunteers: params.maxVolunteers,
      ),
    );
  }
}
