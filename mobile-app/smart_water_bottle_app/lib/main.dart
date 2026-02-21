import 'package:flutter/material.dart';
import 'package:smart_water_bottle_app/screens/profile_screen.dart';
//import 'screens/main_navigation.dart';





void main() {
  runApp(const SmartWaterBottleApp());
}

class SmartWaterBottleApp extends StatelessWidget {
  const SmartWaterBottleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

