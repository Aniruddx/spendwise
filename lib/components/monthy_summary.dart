// monthly_summary_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/data/expense_data.dart';

class MonthlySummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the ExpenseData provider
    ExpenseData expenseData = Provider.of<ExpenseData>(context);

    // Calculate monthly summary
    Map<String, double> monthlySummary = expenseData.calculateMonthlyExpenseSummary();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Monthly Expense Summary'
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(height: 20),
            // Display your monthly summary data here
            Column(
              children: monthlySummary.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key), // Month and year
                  subtitle: Text('Total: \Rs. ${entry.value.toStringAsFixed(2)}'), // Total expense for the month
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
