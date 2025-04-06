import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bus.dart';
import '../providers/bus_provider.dart';
import '../providers/driver_provider.dart';
import 'schedule_item.dart';
import 'add_schedule_dialog.dart';

class BusCard extends ConsumerStatefulWidget {
  final Bus bus;

  const BusCard({super.key, required this.bus});

  @override
  ConsumerState<BusCard> createState() => _BusCardState();
}

class _BusCardState extends ConsumerState<BusCard> {
  bool _isExpanded = false;

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
      case BusType.tourist:
        return 'Туристический';
    }
  }

  void _addSchedule() {
    showDialog(
      context: context,
      builder: (context) => AddScheduleDialog(bus: widget.bus),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.directions_bus,
              color: Color(widget.bus.colorCode),
              size: 32,
            ),
            title: Text(
              '${widget.bus.brand} ${widget.bus.model}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(widget.bus.plateNumber),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
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
                  child: Text(_getTypeText(widget.bus.type)),
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
                  child: Text(_getStatusText(widget.bus.status)),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Расписание',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addSchedule,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...widget.bus.schedules.map((schedule) => ScheduleItem(
                        schedule: schedule,
                        busId: widget.bus.id,
                      )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
} 