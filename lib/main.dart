import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spendwise/data/expense_data.dart';
import 'package:spendwise/homepage.dart';
import 'package:provider/provider.dart';

void main() async {

  //initialise hive
  await Hive.initFlutter();
  //open a hive box
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //create (context) => ExpenseData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ), 
      create: (context) =>ExpenseData(),
    );
  }
}