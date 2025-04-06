import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bus.dart';
import '../providers/bus_provider.dart';
import '../widgets/bus_card.dart';
import '../widgets/add_bus_dialog.dart';

class BusesScreen extends ConsumerWidget {
  const BusesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busesStream = ref.watch(busListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Автобусы'),
      ),
      body: busesStream.when(
        data: (buses) => ListView.builder(
          itemCount: buses.length,
          itemBuilder: (context, index) {
            return BusCard(bus: buses[index]);
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
            builder: (context) => const AddBusDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 