import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/DateTime/date_time_helper.dart';
import 'package:spendwise/bargraph/bargraph.dart';
import 'package:spendwise/data/expense_data.dart';

class ExpenseSummary extends StatelessWidget {

  final DateTime startOfWeek;
  const ExpenseSummary({
    Key? key, // Corrected this line
    required this.startOfWeek,
  }) : super(key: key);

  //calculate max amount of bar graph
  double calculateMax(ExpenseData value, String sunday,String monday, String tuesday, String wednesday, String thursday, String friday, String saturday){
    double? max=1000;
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday]??0,
      value.calculateDailyExpenseSummary()[monday]??0,
      value.calculateDailyExpenseSummary()[tuesday]??0,
      value.calculateDailyExpenseSummary()[wednesday]??0,
      value.calculateDailyExpenseSummary()[thursday]??0,
      value.calculateDailyExpenseSummary()[friday]??0,
      value.calculateDailyExpenseSummary()[saturday]??0,
    ];

    values.sort(); //smallest to largest
    max = values.last * 1.1;

    return max == 0 ?1000:max;

  }

  String calculateWeekTotal (ExpenseData value, String sunday,String monday, String tuesday, String wednesday, String thursday, String friday, String saturday){
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday]??0,
      value.calculateDailyExpenseSummary()[monday]??0,
      value.calculateDailyExpenseSummary()[tuesday]??0,
      value.calculateDailyExpenseSummary()[wednesday]??0,
      value.calculateDailyExpenseSummary()[thursday]??0,
      value.calculateDailyExpenseSummary()[friday]??0,
      value.calculateDailyExpenseSummary()[saturday]??0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days:0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days:1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days:2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days:3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days:4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days:5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days:6)));
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [

          Row(
            children: [
              SizedBox(width: 10,),
              const Text('Week Total',
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.yellow),),
              Text('Rs.' + calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.yellow),)
            ],
          ),

          SizedBox(
            height: 300,
            child: MyBarGraph(
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0, 
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0, 
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0, 
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0, 
              thursAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0, 
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0, 
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0, 
              //bottomTitles: ['Su', 'M', 'T', 'W', 'Th', 'F', 'S'],
              maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)),
          ),
        ],
      )
    );
  }
}