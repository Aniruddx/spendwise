import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDatabase {

  //reference our box
  final _mybox = Hive.box("expense_database");

  //write data
  void saveData(List<ExpenseItem> allExpense){
    //hive can only store strings and dateTime, and not custom objects like ExpenseItem
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
        //expense.categories
        
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

  //storing data in our database
  _mybox.put( "All_Expenses", allExpensesFormatted);

  }

  //read data
  List<ExpenseItem> readData(){
    List savedExpenses = _mybox.get("All_Expenses") ?? [];
    List<ExpenseItem> allExpense = [];

    for(int i=0; i<savedExpenses.length; i++){
      //collect indivisual expense data
      String name = savedExpenses[i][0] as String;
      String amount = savedExpenses[i][1] as String;
      DateTime dateTime = savedExpenses[i][2] as DateTime;
      //String categories = savedExpenses[i][3] as String;

      //create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
        //categories: categories
      );

      //add expense to overall list of expenses
      allExpense.add(expense);
    }
    return allExpense;
  }

}

//first we converted expenseitem(the custom data) to simple list to strings to store
//in hive, and then again convert to custom data read and display