import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoTracker'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido a EcoTracker',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
