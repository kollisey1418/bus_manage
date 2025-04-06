import 'package:cloud_firestore/cloud_firestore.dart';

enum BusStatus { active, free, repair }
enum BusType { small, big, tourist }

class BusSchedule {
  final String date;
  final String line;
  final String shift;
  final String time;
  final String? driverId;
  final String? driverName;

  BusSchedule({
    required this.date,
    required this.line,
    required this.shift,
    required this.time,
    this.driverId,
    this.driverName,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'line': line,
      'shift': shift,
      'time': time,
      'driverId': driverId,
      'driverName': driverName,
    };
  }

  factory BusSchedule.fromMap(Map<String, dynamic> map) {
    return BusSchedule(
      date: map['date'] ?? '',
      line: map['line'] ?? '',
      shift: map['shift'] ?? '',
      time: map['time'] ?? '',
      driverId: map['driverId'],
      driverName: map['driverName'],
    );
  }
}

class Bus {
  final String id;
  final String brand;
  final String model;
  final String plateNumber;
  final BusStatus status;
  final BusType type;
  final int colorCode;
  final List<BusSchedule> schedules;

  Bus({
    required this.id,
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.status,
    required this.type,
    required this.colorCode,
    this.schedules = const [],
  });

  factory Bus.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    List<dynamic> schedulesData = data['schedules'] ?? [];
    
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
      schedules: schedulesData.map((schedule) => BusSchedule.fromMap(schedule)).toList(),
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
      'schedules': schedules.map((schedule) => schedule.toMap()).toList(),
    };
  }
} 