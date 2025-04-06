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
} 