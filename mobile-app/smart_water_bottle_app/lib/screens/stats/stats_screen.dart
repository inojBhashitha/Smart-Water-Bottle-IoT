import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> weeklyIntake = [
      1800,
      2100,
      1600,
      2400,
      2000,
      2300,
      1900
    ];

    const double goal = 2500;

    double average =
        weeklyIntake.reduce((a, b) => a + b) / weeklyIntake.length;

    double bestDay =
    weeklyIntake.reduce((a, b) => a > b ? a : b);

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

              // 🔹 Summary Cards
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

              const Text(
                "Weekly Intake",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 260,
                child: BarChart(
                  BarChartData(
                    backgroundColor: Colors.transparent,
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.white10,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = [
                              "M",
                              "T",
                              "W",
                              "T",
                              "F",
                              "S",
                              "S"
                            ];
                            return Text(
                              days[value.toInt()],
                              style: const TextStyle(
                                  color: Colors.white54),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    barGroups: weeklyIntake
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            width: 18,
                            borderRadius:
                            BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: entry.value >= goal
                                  ? [
                                Colors.greenAccent,
                                Colors.green
                              ]
                                  : [
                                const Color(0xFF38BDF8),
                                const Color(0xFF2563EB)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Trend vs Goal",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 260,
                child: LineChart(
                  LineChartData(
                    backgroundColor: Colors.transparent,
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.white10,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(show: false),
                    lineBarsData: [

                      // Intake Line
                      LineChartBarData(
                        spots: weeklyIntake
                            .asMap()
                            .entries
                            .map((e) =>
                            FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF38BDF8),
                            Color(0xFF2563EB)
                          ],
                        ),
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),

                      // Goal Line
                      LineChartBarData(
                        spots: List.generate(
                          weeklyIntake.length,
                              (index) =>
                              FlSpot(index.toDouble(), goal),
                        ),
                        isCurved: false,
                        color: Colors.redAccent,
                        barWidth: 2,
                        dotData: FlDotData(show: false),
                        dashArray: [6, 4],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              hydrationScore(average, goal),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard(
      {required String title,
        required String value,
        required Color color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(title,
              style:
              const TextStyle(color: Colors.white54)),
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

  Widget hydrationScore(double avg, double goal) {
    double score = (avg / goal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Hydration Consistency",
            style:
            TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: score,
            minHeight: 10,
            backgroundColor: Colors.white12,
            color: score > 0.8
                ? Colors.greenAccent
                : score > 0.5
                ? Colors.orangeAccent
                : Colors.redAccent,
          ),
          const SizedBox(height: 10),
          Text(
            "${(score * 100).toInt()}% of goal achieved on average",
            style: const TextStyle(
                color: Colors.white54),
          ),
        ],
      ),
    );
  }
}