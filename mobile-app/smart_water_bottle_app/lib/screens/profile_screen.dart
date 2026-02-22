import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Dummy lifetime stats (later from Firebase)
  int longestStreak = 7;
  int totalDaysTracked = 32;
  int lifetimeIntake = 54000;
  double dailyGoal = 2500;

  String get hydrationRank {
    if (longestStreak >= 10) return "Hydration Elite 💎";
    if (longestStreak >= 5) return "Hydration Pro 🔥";
    return "Hydration Beginner 💧";
  }

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

              const Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // 👤 USER CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xFF2563EB),
                      child: Icon(Icons.person,
                          size: 35, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Smart User",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          hydrationRank,
                          style: const TextStyle(
                              color: Colors.white54),
                        ),
                        const SizedBox(height: 30),

                        // 📊 LIFETIME STATS
                        const Text(
                          "Lifetime Stats",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                                child: statCard(
                                    "Days Tracked",
                                    totalDaysTracked.toString())),
                            const SizedBox(width: 12),
                            Expanded(
                                child: statCard(
                                    "Longest Streak",
                                    "$longestStreak Days")),
                          ],
                        ),

                        const SizedBox(height: 12),

                        statCard("Lifetime Intake",
                            "$lifetimeIntake ml"
                        ),
                        const SizedBox(height: 30),

                        // 🎯 DAILY GOAL
                        const Text(
                          "Daily Goal",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${dailyGoal.toInt()} ml",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Slider(
                                value: dailyGoal,
                                min: 1000,
                                max: 5000,
                                divisions: 16,
                                activeColor:
                                const Color(0xFF2563EB),
                                inactiveColor: Colors.white24,
                                onChanged: (value) {
                                  setState(() {
                                    dailyGoal = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Later: Save to Firebase
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text("Goal Updated")),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xFF2563EB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                ),
                                child:
                                const Text("Save Goal"),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(title,
              style:
              const TextStyle(color: Colors.white54)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}