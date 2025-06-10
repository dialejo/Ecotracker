import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _transportType = 'Bus';
  String _transportFrequency = 'Diaria';
  double _km = 0;
  String _dietType = 'Omnívora';
  bool _eatsMeat = false;

  Map<String, bool> _energyUses = {
    'TV': false,
    'AIRE': false,
    'NEVERA': false,
    'PC': false,
    'DUCHA': false,
    'HORNO': false,
  };

  int _energyHours = 0;
  bool _lightsOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9F7F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTransportSection(),
              const SizedBox(height: 10),
              _buildFoodSection(),
              const SizedBox(height: 10),
              _buildEnergySection(),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Icon(Icons.lock, color: Colors.red, size: 30),
        const Text(
          "Registro de Actividad",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "Veamos tu contribución a la sociedad",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTransportSection() {
    return Container(
      decoration: _sectionDecoration(Colors.blue.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("TRANSPORTE", Icons.directions_bus),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _transportType,
            decoration: const InputDecoration(labelText: 'Tipo'),
            items: ['Bus', 'Carro', 'Bicicleta']
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (value) => setState(() => _transportType = value!),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'KM recorridos'),
            onChanged: (value) =>
                setState(() => _km = double.tryParse(value) ?? 0),
          ),
          DropdownButtonFormField<String>(
            value: _transportFrequency,
            decoration: const InputDecoration(labelText: 'Frecuencia'),
            items: ['Diaria', 'Semanal', 'Mensual']
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (value) =>
                setState(() => _transportFrequency = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodSection() {
    return Container(
      decoration: _sectionDecoration(Colors.pink.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("ALIMENTACIÓN", Icons.restaurant),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _dietType,
            decoration: const InputDecoration(labelText: 'Tipo de dieta'),
            items: ['Omnívora', 'Vegetariana', 'Vegana']
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (value) => setState(() => _dietType = value!),
          ),
          CheckboxListTile(
            title: const Text("Comidas con carne"),
            value: _eatsMeat,
            onChanged: (val) => setState(() => _eatsMeat = val!),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergySection() {
    return Container(
      decoration: _sectionDecoration(Colors.green.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("ENERGÍA", Icons.bolt),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: _energyUses.keys.map((key) {
              return FilterChip(
                label: Text(key),
                selected: _energyUses[key]!,
                onSelected: (val) =>
                    setState(() => _energyUses[key] = val),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(labelText: 'Horas de uso'),
            onChanged: (val) =>
                setState(() => _energyHours = int.tryParse(val) ?? 0),
          ),
          SwitchListTile(
            title: const Text("Luces apagadas"),
            value: _lightsOff,
            onChanged: (val) => setState(() => _lightsOff = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Actividad registrada!')),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7B61FF),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text("GUARDAR", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  BoxDecoration _sectionDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    );
  }
}
