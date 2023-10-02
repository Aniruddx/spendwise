import 'package:flutter/material.dart';
import 'package:spendwise/DateTime/date_time_helper.dart';
import 'package:spendwise/data/hive_database.dart';
import 'package:spendwise/models/expense_item.dart';
//import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {

  //list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //prepare data to display
  final db = HiveDatabase();
  void prepareData(){
    if (db.readData().isNotEmpty){
      overallExpenseList = db.readData();
    }
  }

  //adding a new expense
  void addNewExpense(ExpenseItem NewExpense){
    overallExpenseList.add(NewExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense){
    overallExpenseList.remove(expense);

    notifyListeners();
  }

  //get weekday form dateTime object
  String getDayName(DateTime dateTime){
    switch (dateTime.weekday){
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  //get date for start of week (Sun)
    DateTime? startOfWeekDate(){
    DateTime? startOfWeek;
    DateTime today = DateTime.now(); //get today's date

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek;
  }


  Map<String, double> calculateMonthlyExpenseSummary() {
  Map<String, double> monthlyExpenseSummary = {};

  for (var expense in overallExpenseList) {
    String monthYearKey = '${expense.dateTime.month}/${expense.dateTime.year}';

    monthlyExpenseSummary[monthYearKey] ??= 0.0;
    
    monthlyExpenseSummary[monthYearKey] = (monthlyExpenseSummary[monthYearKey] ?? 0.0) + double.parse(expense.amount);
  }

  return monthlyExpenseSummary;
}


  Map <String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date (yyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList){
      String date = convertDateTimeToString(expense.dateTime as DateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }
      else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}