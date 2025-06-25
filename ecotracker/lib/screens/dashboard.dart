import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F7F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 20),
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildProgressCard(),
              const SizedBox(height: 30),
              const Text(
                "Cosas que puedes hacer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              _buildActionGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu, size: 30),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(
            'assets/user.png',
          ), // Usa NetworkImage o placeholder si quieres
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hola! Diego Maldonado",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "Veamos tu contribución a la sociedad",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF195A54),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 10.0,
            percent: 0.76,
            center: const Text(
              "76%",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            progressColor: Colors.greenAccent,
            backgroundColor: Colors.white12,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Buen Trabajo, Diego",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                _ProgressItem(
                  label: "Compra Intel",
                  percent: "+2%",
                  color: Colors.greenAccent,
                ),
                _ProgressItem(
                  label: "Plantar árbol",
                  percent: "+4%",
                  color: Colors.greenAccent,
                ),
                _ProgressItem(
                  label: "Ahorro de energía",
                  percent: "+2%",
                  color: Colors.greenAccent,
                ),
                _ProgressItem(
                  label: "Bicicleta",
                  percent: "-2%",
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    final actions = [
      _ActionItem(
        label: 'Registrar Actividad',
        icon: Icons.lock,
        color: Colors.pink.shade100,
        subtitle: '4 Checklists',
        route: '/activity',
      ),
      _ActionItem(
        label: 'Ahorro de Energía',
        icon: Icons.lightbulb_outline,
        color: Colors.yellow.shade100,
        subtitle: '6 Devices',
      ),
      _ActionItem(
        label: 'Plantar Árbol',
        icon: Icons.park,
        color: Colors.green.shade100,
        subtitle: '5 Checklists',
      ),
      _ActionItem(
        label: 'Montar Bicicleta',
        icon: Icons.directions_bike,
        color: Colors.blue.shade100,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 4 / 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: actions.map((a) => _buildActionCard(context, a)).toList(),
    );
  }

  Widget _buildActionCard(BuildContext context, _ActionItem item) {
    return GestureDetector(
      onTap: () {
        if (item.route != null) {
          Navigator.pushNamed(context, item.route!);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, size: 28, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              item.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (item.subtitle.isNotEmpty)
              Text(
                item.subtitle,
                style: const TextStyle(color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String percent;
  final Color color;

  const _ProgressItem({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label, style: TextStyle(color: Colors.white)),
          ),
          Text(percent, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

class _ActionItem {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? route;

  _ActionItem({
    required this.label,
    required this.icon,
    required this.color,
    this.subtitle = '',
    this.route,
  });
}
