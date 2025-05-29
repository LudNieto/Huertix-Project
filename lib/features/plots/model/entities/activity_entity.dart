import 'package:equatable/equatable.dart';

enum TipoActividadEnum {sembrar, regar, podar, limpiar, cosechar,}
enum EstadoActividadEnum {pendiente, sinResponsable, completada,}

String tipoActividadEnumToString(TipoActividadEnum tipo) {
  switch (tipo) {
    case TipoActividadEnum.sembrar:
      return 'sembrar';
    case TipoActividadEnum.regar:
      return 'regar';
    case TipoActividadEnum.podar:
      return 'podar';
    case TipoActividadEnum.limpiar:
      return 'limpiar';
    case TipoActividadEnum.cosechar:
      return 'cosechar';
  }
}

TipoActividadEnum stringToTipoActividadEnum(String? tipoString) {
  switch (tipoString?.toLowerCase()) {
    case 'sembrar':
      return TipoActividadEnum.sembrar;
    case 'regar':
      return TipoActividadEnum.regar;
    case 'podar':
      return TipoActividadEnum.podar;
    case 'limpiar':
      return TipoActividadEnum.limpiar;
    case 'cosechar':
      return TipoActividadEnum.cosechar;
    default:
      throw ArgumentError('Tipo de actividad desconocido: $tipoString');
  }
}

String estadoActividadEnumToString(EstadoActividadEnum estado) {
  switch (estado) {
    case EstadoActividadEnum.pendiente:
      return 'pendiente';
    case EstadoActividadEnum.sinResponsable:
      return 'sinResponsable';
    case EstadoActividadEnum.completada:
      return 'completada';
  }
}

EstadoActividadEnum stringToEstadoActividadEnum(String? estadoString) {
  switch (estadoString?.toLowerCase()) {
    case 'pendiente':
      return EstadoActividadEnum.pendiente;
    case 'sinresponsable':
      return EstadoActividadEnum.sinResponsable;
    case 'completada':
      return EstadoActividadEnum.completada;
    default:
      throw ArgumentError('Estado de actividad desconocido: $estadoString');
  }
}

class ActivityEntity extends Equatable {
  final String id;
  final String idPlot;
  final String nameActivity;
  final TipoActividadEnum type;
  final DateTime dateTimePlanned;
  final EstadoActividadEnum status;
  final String idAssignedResponsible;

  const ActivityEntity({
    required this.id,
    required this.idPlot,
    required this.nameActivity,
    required this.type,
    required this.dateTimePlanned,
    required this.status,
    required this.idAssignedResponsible,
  });

  @override
  List<Object?> get props => [id, idPlot, nameActivity, type, dateTimePlanned, status, idAssignedResponsible];
}