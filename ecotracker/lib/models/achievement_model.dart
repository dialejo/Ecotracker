class Achievement {
  final String title;
  final String status; // Ej: "En progreso" o "Completado"
  final String iconPath;
  final bool completed;

  Achievement({
    required this.title,
    required this.status,
    required this.iconPath,
    required this.completed,
  });
}