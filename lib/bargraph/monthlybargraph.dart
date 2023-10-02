import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/bargraph/monthlybardata.dart';

class MyMBarGraph extends StatelessWidget {

  final double? maxY;
  final double janAmount;
  final double febAmount;
  final double marAmount;
  final double aprAmount;
  final double mayAmount;
  final double junAmount;
  final double julAmount;
  final double augAmount;
  final double sepAmount;
  final double octAmount;
  final double novAmount;
  final double decAmount;

  const MyMBarGraph({
    super.key,
    required this.janAmount,
    required this.febAmount,
    required this.marAmount,
    required this.aprAmount,
    required this.mayAmount,
    required this.junAmount,
    required this.julAmount,
    required this.augAmount,
    required this.sepAmount,
    required this.octAmount,
    required this.novAmount,
    required this.decAmount,
    required this.maxY,
  });
  
  @override
  Widget build(BuildContext context) {
    MBarData myBarData = MBarData(
      janAmount: janAmount,
      febAmount: febAmount,
      marAmount: marAmount,
      aprAmount: aprAmount,
      mayAmount: mayAmount,
      junAmount: junAmount,
      julAmount: julAmount,
      augAmount: augAmount,
      sepAmount: sepAmount,
      octAmount: octAmount,
      novAmount: novAmount,
      decAmount: decAmount
      );
    
    myBarData.initialiseBarData();
    return BarChart(
      BarChartData(
        backgroundColor: Color.fromARGB(255, 99, 34, 212),
        maxY: maxY, 
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
          getTitlesWidget: getBottomTitles),)
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData.map(
          (data)=>BarChartGroupData(x: data.x,
          barRods: [BarChartRodData(
            toY: data.y,
            color: Colors.grey,
            width: 20,
            borderRadius: BorderRadius.circular(4)
            )])
          ).toList(),
      )
    );
  }
}
Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 15);
    Widget text;
    switch(value.toInt()){
      case 0: text = const Text('Jan',style: style );
      break;
      case 1: text = const Text('Feb',style: style );
      break;
      case 2: text = const Text('Mar',style: style );
      break;
      case 3: text = const Text('Apr',style: style );
      break;
      case 4: text = const Text('May',style: style );
      break;
      case 5: text = const Text('Jun',style: style );
      break;
      case 6: text = const Text('Jul',style: style );
      break;
      case 7: text = const Text('Aug',style: style );
      break;
      case 8: text = const Text('Sep',style: style );
      break;
      case 9: text = const Text('Oct',style: style );
      break;
      case 10: text = const Text('Mov',style: style );
      break;
      case 11: text = const Text('Dec',style: style );
      break;
      default: text = const Text('',style: style );
      break;
    }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}