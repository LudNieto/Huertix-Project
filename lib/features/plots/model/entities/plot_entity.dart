import 'package:equatable/equatable.dart';

enum PlotStatusEnum {disponible, noDisponible,}

String plotStatusEnumToString(PlotStatusEnum status) {
  switch (status) {
    case PlotStatusEnum.disponible:
      return 'Disponible';
    case PlotStatusEnum.noDisponible:
      return 'No Disponible';
  }
}

PlotStatusEnum stringToPlotStatusEnum(String? statusString) {
  switch (statusString?.toLowerCase()) {
    case 'disponible':
      return PlotStatusEnum.disponible;
    case 'nodisponible':
      return PlotStatusEnum.noDisponible;
    default:
      throw ArgumentError('Estado de parcela desconocido: $statusString');
  }
}



class PlotEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String size;
  final String currentCrops;
  final PlotStatusEnum status;
  final DateTime createdAt;
  final int maxVolunteers;
  final List<String> idVolunteers;
  final List<String> idApplicantUsers;


  const PlotEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.size,
    required this.currentCrops,
    required this.status,
    required this.createdAt,
    required this.maxVolunteers,
    this.idVolunteers = const [],
    this.idApplicantUsers = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        size,
        currentCrops,
        status,
        createdAt,
        maxVolunteers,
        idApplicantUsers,
        idVolunteers,
      ];

  PlotEntity copyWith({
    String? id,
    String? name,
    String? size,
    String? location,
    String? currentCrop,
    String? status,
    DateTime? createdAt,
    List<String>? applicantUserIds,
    List<String>? volunteerUserIds,
    int? maxVolunteers,
  }) {
    return PlotEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      location: location ?? this.location,
      currentCrops: currentCrop ?? this.currentCrops,
      status: stringToPlotStatusEnum(status) ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      idApplicantUsers: applicantUserIds ?? this.idApplicantUsers,
      idVolunteers: volunteerUserIds ?? this.idVolunteers,
      maxVolunteers: maxVolunteers ?? this.maxVolunteers,
    );
  }

}