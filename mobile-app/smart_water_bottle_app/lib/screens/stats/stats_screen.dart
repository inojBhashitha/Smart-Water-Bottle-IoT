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

              // Title
              const Text(
                "Hydration Insights",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // Stats Cards
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

              // Bar Chart Title
              const Text(
                "Weekly Intake",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Bar Chart
              SizedBox(
                height: 260,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    barGroups: weeklyIntake.asMap().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value.toDouble(),
                            width: 18,
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: entry.value >= goal
                                  ? [Colors.greenAccent, Colors.green]
                                  : [const Color(0xFF38BDF8), const Color(0xFF2563EB)],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Line Chart Title
              const Text(
                "Trend vs Goal",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Line Chart with Goal Line
              SizedBox(
                height: 260,
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    lineBarsData: [
                      // Weekly intake line
                      LineChartBarData(
                        spots: weeklyIntake
                            .asMap()
                            .entries
                            .map((e) => FlSpot(
                          e.key.toDouble(),
                          e.value.toDouble(),
                        ))
                            .toList(),
                        isCurved: true,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
                        ),
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),

                      // Goal dashed line
                      LineChartBarData(
                        spots: List.generate(
                          weeklyIntake.length,
                              (index) => FlSpot(index.toDouble(), goal),
                        ),
                        color: Colors.redAccent,
                        dashArray: [6, 4],
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Hydration Score
              hydrationScore(average, goal),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable Stat Card
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
        ),
      ],
    ),
  );
}

/// Hydration Score Widget
Widget hydrationScore(double avg, double goal) {
  final double score = (avg / goal).clamp(0.0, 1.0);

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hydration Score",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: score,
          backgroundColor: Colors.white12,
          color: Colors.greenAccent,
        ),
        const SizedBox(height: 8),
        Text(
          "${(score * 100).toInt()}%",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}