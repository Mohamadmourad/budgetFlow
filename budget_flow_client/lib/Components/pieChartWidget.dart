import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final double value1;
  final double value2;

  const PieChartWidget({super.key, required this.value1, required this.value2});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: showingSections(),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final double total = value1 + value2;
    return [
      PieChartSectionData(
        color: const Color(0xff0293ee),
        value: value1,
        title: '${(value1 / total * 100).toStringAsFixed(1)}% \n L.L',
        radius: 50,
        titleStyle:const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color:  Color(0xffffffff),
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: value2,
        title: '${(value2 / total * 100).toStringAsFixed(1)}% \n USD',
        radius: 50,
        titleStyle:const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      ),
    ];
  }
}
