import 'package:flutter/material.dart';
import '../models/bus.dart';

class BusCard extends StatelessWidget {
  final Bus bus;

  const BusCard({super.key, required this.bus});

  String _getStatusText(BusStatus status) {
    switch (status) {
      case BusStatus.active:
        return 'Активен';
      case BusStatus.free:
        return 'Свободен';
      case BusStatus.repair:
        return 'В ремонте';
    }
  }

  String _getTypeText(BusType type) {
    switch (type) {
      case BusType.small:
        return 'Малый';
      case BusType.big:
        return 'Большой';
      case BusType.tour:
        return 'Туристический';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.directions_bus,
                  color: Color(bus.colorCode),
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${bus.brand} ${bus.model}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        bus.plateNumber,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(_getTypeText(bus.type)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(_getStatusText(bus.status)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 