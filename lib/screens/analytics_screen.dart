import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Аналитика'),
      ),
      body: Center(
        child: Text('Экран аналитики'),
      ),
    );
  }
} 