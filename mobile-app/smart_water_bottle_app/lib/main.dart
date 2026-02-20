import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(const SmartWaterBottleApp());
}

class SmartWaterBottleApp extends StatelessWidget {
  const SmartWaterBottleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigation(),
    );
  }
}

