import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huertix_project/features/plots/model/entities/plot_entity.dart';

class PlotModel extends PlotEntity {
  const PlotModel({
    required super.id,
    required super.name,
    required super.location,
    required super.size,
    required super.currentCrops,
    required super.status,
    required super.createdAt,
    required super.maxVolunteers,
    super.volunteersCount,
  });

  factory PlotModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Parcela no contiene datos (ID: ${doc.id})");
    }
    return PlotModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      location: data['location'] as String? ?? '',
      size: data['size'] as String? ?? '',
      currentCrops: data['currentCrops'] as String? ?? '',
      status: stringToPlotStatusEnum(data['status'] as String?),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      maxVolunteers: (data['maxVolunteers'] as num?)?.toInt() ?? 0,
      volunteersCount: (data['volunteersCount'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'location': location,
      'size': size,
      'currentCrops': currentCrops,
      'status': plotStatusEnumToString(status),
      'createdAt': createdAt,
      'maxVolunteers': maxVolunteers,
      'volunteersCount': volunteersCount ?? 0,
    };
  }
}