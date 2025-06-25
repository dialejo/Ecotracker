import 'package:flutter/material.dart';
import '../models/achievement_model.dart';

class AchievementsScreen extends StatelessWidget {
  AchievementsScreen({super.key});

  final List<Achievement> achievements = [
    Achievement(
      title: "ECOVIAJERO",
      status: "En progreso.",
      iconPath: "assets/icons/bike.png",
      completed: false,
    ),
    Achievement(
      title: "AHORRO ENERGÍA",
      status: "En progreso.",
      iconPath: "assets/icons/energy.png",
      completed: false,
    ),
    Achievement(
      title: "SEMANA VERDE",
      status: "En progreso.",
      iconPath: "assets/icons/tree.png",
      completed: false,
    ),
    Achievement(
      title: " ",
      status: "Completado.",
      iconPath: "assets/icons/medal.png",
      completed: true,
    ),
  ];

  double get completionPercent {
    final total = achievements.length;
    final completed = achievements.where((a) => a.completed).length;
    return (completed / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: const Text("Logros y Recompensas"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Icon(Icons.emoji_events, size: 64, color: Colors.orange),
          const SizedBox(height: 8),
          Text("${completionPercent.toStringAsFixed(0)}%", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("¡EMPECEMOS!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: LinearProgressIndicator(
              value: completionPercent / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 20),
          const Text("RETOS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final ach = achievements[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: ach.completed
                          ? const Icon(Icons.check_box, color: Colors.green)
                          : Image.asset(ach.iconPath, height: 30),
                      title: Text(ach.title),
                      subtitle: Text(ach.status),
                      trailing: ach.completed ? const Icon(Icons.check, color: Colors.green) : const Icon(Icons.hourglass_empty),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
