import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/driver.dart';
import '../providers/driver_provider.dart';
import '../widgets/driver_card.dart';
import '../widgets/add_driver_dialog.dart';

class DriversScreen extends ConsumerWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driversStream = ref.watch(driverListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Водители'),
      ),
      body: driversStream.when(
        data: (drivers) => ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return DriverCard(driver: drivers[index]);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Ошибка: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddDriverDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 