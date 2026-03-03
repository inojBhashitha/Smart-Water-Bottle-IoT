import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double intake = 1200;
  double goal = 2500;

  @override
  Widget build(BuildContext context) {
    double progress = (intake / goal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // 🔥 Header
                const Text(
                  "Hydration Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // 💧 Main Progress Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF1E3A8A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Today's Hydration",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Stack(
                        alignment: Alignment.center,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: progress),
                            duration: const Duration(milliseconds: 800),
                            builder: (context, value, child) {
                              return SizedBox(
                                width: 160,
                                height: 160,
                                child: CircularProgressIndicator(
                                  value: value,
                                  strokeWidth: 12,
                                  backgroundColor: Colors.white24,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    value > 0.7
                                        ? Colors.greenAccent
                                        : value > 0.4
                                        ? Colors.orangeAccent
                                        : Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                          Column(
                            children: [
                              Text(
                                "${intake.toInt()} ml",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Goal: ${goal.toInt()} ml",
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Quick Stats",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // 📊 Stats Grid
                Row(
                  children: [
                    Expanded(child: statCard("🌡", "28°C", "Temperature")),
                    const SizedBox(width: 15),
                    Expanded(child: statCard("🧪", "Good", "Water Quality")),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(child: statCard("🔥", "3 Days", "Streak")),
                    const SizedBox(width: 15),
                    Expanded(child: statCard("💧", "2.5L", "Daily Goal")),
                  ],
                ),

                const SizedBox(height: 40),

                // 💦 Add Water Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        intake += 250;
                        if (intake > goal) intake = goal;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Add 250ml",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Modern Stat Card
  Widget statCard(String emoji, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}