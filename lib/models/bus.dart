import 'package:cloud_firestore/cloud_firestore.dart';

enum BusStatus { active, free, repair }
enum BusType { small, big, tour }

class Bus {
  final String id;
  final String brand;
  final String model;
  final String plateNumber;
  final BusStatus status;
  final BusType type;
  final int colorCode;

  Bus({
    required this.id,
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.status,
    required this.type,
    required this.colorCode,
  });

  factory Bus.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Bus(
      id: doc.id,
      brand: data['brand'] ?? '',
      model: data['model'] ?? '',
      plateNumber: data['plateNumber'] ?? '',
      status: BusStatus.values.firstWhere(
        (e) => e.toString() == 'BusStatus.${data['status']}',
        orElse: () => BusStatus.free,
      ),
      type: BusType.values.firstWhere(
        (e) => e.toString() == 'BusType.${data['type']}',
        orElse: () => BusType.small,
      ),
      colorCode: data['colorCode'] ?? 0xFF000000,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'plateNumber': plateNumber,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'colorCode': colorCode,
    };
  }
} 