import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:smart_water_bottle_app/screens/stats/stats_screen.dart';
import 'screens/stats/stats_screen.dart';

void main() {
  runApp(const SmartWaterBottleApp());
}

class SmartWaterBottleApp extends StatelessWidget {
  const SmartWaterBottleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const StatsScreen(),
    );
  }
}
