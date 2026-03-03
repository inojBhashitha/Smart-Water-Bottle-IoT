import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double intake = 1200;
  double goal = 2500;

  void _addWater() {
    setState(() {
      if (intake < goal) intake += 250;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = intake / goal;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Hydration Coach"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Hydration Progress Circle
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 15,
                    backgroundColor: Colors.blue[100],
                    color: Colors.blueAccent,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${intake.toInt()} ml",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Goal: ${goal.toInt()} ml"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 40),

            infoCard("Water Temperature", "28°C"),
            const SizedBox(height: 15),
            infoCard("Water Quality (TDS)", "Good"),
            const SizedBox(height: 15),
            infoCard("Daily Streak", "3 Days 🔥"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWater,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget infoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
