import 'package:flutter/material.dart';

class DriversScreen extends StatelessWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Водители'),
      ),
      body: Center(
        child: Text('Экран водителей'),
      ),
    );
  }
} 