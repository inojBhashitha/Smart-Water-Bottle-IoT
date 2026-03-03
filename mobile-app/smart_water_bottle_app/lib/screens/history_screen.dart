import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historyData = [
      {"date": "2026-02-20", "intake": 2400, "goal": 2500, "temp": 27, "tds": 140},
      {"date": "2026-02-19", "intake": 2100, "goal": 2500, "temp": 28, "tds": 150},
      {"date": "2026-02-18", "intake": 2600, "goal": 2500, "temp": 26, "tds": 135},
      {"date": "2026-02-17", "intake": 1800, "goal": 2500, "temp": 29, "tds": 160},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hydration History",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}