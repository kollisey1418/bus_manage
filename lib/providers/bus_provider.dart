import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/bus.dart';

part 'bus_provider.g.dart';

@riverpod
class BusList extends _$BusList {
  @override
  Stream<List<Bus>> build() {
    return FirebaseFirestore.instance
        .collection('Buses')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Bus.fromFirestore(doc))
            .toList());
  }

  Future<void> addBus(Bus bus) async {
    await FirebaseFirestore.instance
        .collection('Buses')
        .add(bus.toMap());
  }

  Future<void> updateBusSchedule(String busId, List<BusSchedule> schedules) async {
    await FirebaseFirestore.instance
        .collection('Buses')
        .doc(busId)
        .update({
          'schedules': schedules.map((s) => s.toMap()).toList(),
        });
  }

  Future<void> addSchedule(String busId, BusSchedule schedule) async {
    final busDoc = await FirebaseFirestore.instance
        .collection('Buses')
        .doc(busId)
        .get();
    
    if (!busDoc.exists) return;

    final bus = Bus.fromFirestore(busDoc);
    final updatedSchedules = [...bus.schedules, schedule];

    await updateBusSchedule(busId, updatedSchedules);
  }
} 