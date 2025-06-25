import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EnergySavingsScreen extends StatefulWidget {
  @override
  _EnergySavingsScreenState createState() => _EnergySavingsScreenState();
}

class _EnergySavingsScreenState extends State<EnergySavingsScreen> {
  Map<String, bool> deviceStates = {
    'Aire Acondicionado': true,
    'Luces Cocina': false,
    'TV': true,
    'PC Escritorio': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildStats(),
                    SizedBox(height: 24),
                    _buildChart(),
                    SizedBox(height: 20),
                    _buildRecommendationCard(),
                    SizedBox(height: 20),
                    _buildDeviceList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back, color: Colors.white),
          Text(
            'Ahorro de Energía',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.add, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statTile("Hoy", "238 kWh"),
        _statTile("Este Mes", "1344.68 kWh"),
        _statTile("Ahorro CO₂", "4230.54 kg"),
      ],
    );
  }

  Widget _statTile(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green.shade800)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Consumo por hora",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      const labels = [
                        '8 am',
                        '9 am',
                        '10 am',
                        '11 am',
                        '12 pm',
                        '1 pm'
                      ];
                      if (value % 2 == 0 && value ~/ 2 < labels.length) {
                        return Text(labels[value ~/ 2]);
                      }
                      return Text('');
                    },
                    interval: 2,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 0.5),
                    FlSpot(1, 1.0),
                    FlSpot(2, 0.8),
                    FlSpot(3, 1.5),
                    FlSpot(4, 2.8),
                    FlSpot(5, 0.6),
                  ],
                  isCurved: true,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.4),
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange),
          SizedBox(width: 12),
          Expanded(
              child: Text(
                  'Calefacción está consumiendo 4 kWh. Apágalo para ahorrar energía.')),
          SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {},
            child: Text('Apagar'),
          )
        ],
      ),
    );
  }

  Widget _buildDeviceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("My Devices",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.sort, size: 16),
              label: Text("Sort By"),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          ],
        ),
        SizedBox(height: 12),
        ...deviceStates.entries.map((entry) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink.shade50,
                child: Icon(Icons.ac_unit, color: Colors.pink),
              ),
              title: Text(entry.key),
              subtitle: Text(
                  'Consuming ${(entry.value ? 10.0 : 0.0).toStringAsFixed(1)} kWh'),
              trailing: Switch(
                value: entry.value,
                onChanged: (val) {
                  setState(() {
                    deviceStates[entry.key] = val;
                  });
                },
              ),
            ),
          );
        }).toList()
      ],
    );
  }
}
