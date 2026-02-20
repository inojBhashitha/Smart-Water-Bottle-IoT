import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Hydration Stats 📊',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Stats Dashboard Loading...'), //
      ),
    );
  }
}