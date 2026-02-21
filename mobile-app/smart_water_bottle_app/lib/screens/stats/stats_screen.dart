import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
          'Hydration Stats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Hydration',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your water intake over the last 7 days',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 3000,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey);
                          switch (value.toInt()) {
                            case 0: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Mon', style: style));
                            case 1: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Tue', style: style));
                            case 2: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Wed', style: style));
                            case 3: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Thu', style: style));
                            case 4: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Fri', style: style));
                            case 5: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Sat', style: style));
                            case 6: return SideTitleWidget(axisSide: meta.axisSide, child: const Text('Sun', style: style));
                            default: return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text('${value.toInt()}ml', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    makeGroupData(0, 1500),
                    makeGroupData(1, 2200),
                    makeGroupData(2, 1800),
                    makeGroupData(3, 2500),
                    makeGroupData(4, 2000),
                    makeGroupData(5, 2800),
                    makeGroupData(6, 1200),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blueAccent,
          width: 18,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}