import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  static final List<int> weeklyIntake = [1800, 2100, 1600, 2400, 2000, 2300, 1900];
  static const double goal = 2500;

  static final double average =
      weeklyIntake.reduce((a, b) => a + b) / weeklyIntake.length;

  static final int bestDay =
  weeklyIntake.reduce((a, b) => a > b ? a : b);

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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: statCard(
                      title: "Weekly Avg",
                      value: "${average.toInt()} ml",
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: statCard(
                      title: "Best Day",
                      value: "${bestDay.toInt()} ml",
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Stat Card
Widget statCard({
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white54),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const Text("Weekly Intake", style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                barGroups: weeklyIntake.asMap().entries.map((entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      width: 18,
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: entry.value >= goal ? [Colors.greenAccent, Colors.green] : [const Color(0xFF38BDF8), const Color(0xFF2563EB)]),
                    ),
                  ],
                )).toList(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}