import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hydration Insights",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
            ],
              final List weeklyIntake = [1800, 2100, 1600, 2400, 2000, 2300, 1900];
          const double goal = 2500;
          double average = weeklyIntake.reduce((a, b) => a + b) / weeklyIntake.length;
          double bestDay = weeklyIntake.reduce((a, b) => a > b ? a : b);
          ),
        ),
      ),
    );

  }
}