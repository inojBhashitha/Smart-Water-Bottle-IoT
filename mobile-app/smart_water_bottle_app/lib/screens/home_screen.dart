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
      if (intake < goal) {
        intake += 250;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Amazing! Added 250ml of water 💧"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        if (intake >= goal) {
          _showGoalReachedDialog();
        }
      }
    });
  }

  void _resetWater() {
    setState(() {
      intake = 0;
    });
  }

  void _showGoalReachedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Goal Reached! 🏆", textAlign: TextAlign.center),
        content: const Text(
          "Congratulations! You have successfully reached your hydration goal for today.",
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text("Awesome!"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = intake / goal;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Hydration Coach",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetWater,
            icon: const Icon(Icons.refresh_rounded, color: Colors.blueAccent),
            tooltip: 'Reset Intake',
          ),
        ],
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
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
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

            infoCard("Water Temperature", "28°C", Icons.thermostat_outlined, Colors.orange),
            const SizedBox(height: 15),
            infoCard("Water Quality (TDS)", "Good", Icons.water_drop_outlined, Colors.blue),
            const SizedBox(height: 15),
            infoCard("Daily Streak", "3 Days 🔥", Icons.local_fire_department_outlined, Colors.redAccent),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addWater,
        icon: const Icon(Icons.add_rounded),
        label: const Text("Add Water"),
        elevation: 4,
      ),
    );
  }

  Widget infoCard(String title, String value, IconData icon, Color iconColor) {
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
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
