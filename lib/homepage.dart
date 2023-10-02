import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/components/expense_summary.dart';
import 'package:spendwise/components/expensetile.dart';
import 'package:spendwise/components/monthy_summary.dart';
import 'package:spendwise/data/expense_data.dart';
import 'package:spendwise/models/expense_item.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //List<String> categories = ['Utilities', 'Transportation', 'Food and Groceries', 'Health', 'Miscellaneous'];
  //String selectedCategory = 'Utilities';

  //textcontrollers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

 


  void addNewExpense (){
    showDialog(context: context, 
    builder: (context)=> AlertDialog(
      title: Text('Add new Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //expense name
          TextField(
            controller: newExpenseNameController,
            decoration: InputDecoration(
              hintText: "Expense Name"
            ),
          ),

          //expense amount
          TextField(
            controller: newExpenseAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Amount"
            ),
          ),

          //expense category dropdown
          /*DropdownButton<String>(
            value: selectedCategory, 
            onChanged: (String? newValue){
              setState(() {
                selectedCategory = newValue!;
              });
            }, 
            items: categories.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String> (
                value: value,
                child: Text(value),
              );
            }).toList(),
            )*/
        ],
      ),
      actions: [
        //save button
        MaterialButton(onPressed: save,
        child: Text('save'),),

        //cancel button
        MaterialButton(onPressed: cancel,
        child: Text('cancel'),)
      ],
    ));
  }

  //delete the expense
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }


  void save (){
    //create expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text, 
      amount: newExpenseAmountController.text, 
      dateTime: DateTime.now(),
      //categories: selectedCategory
      );

    //add new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }
  void cancel (){
    Navigator.pop(context);
    clear();
  }

  void clear (){
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override

   void initState(){
    super.initState();

    //prepare data on start-up
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }


  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child)=>Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.menu_sharp), 
              onPressed: () {
              },
            ),

            Text(
              'Weekly Expense',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,      
              ),
            ),

            IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.arrow_forward_ios), 
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MonthlySummaryPage()),
                );
              },
            )
        ],
        ) ,
        ),
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          
          //weekly summary
          //SizedBox(height: 30,),
          Container(
            //color: Colors.deepPurple,
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            padding: EdgeInsets.only(bottom: 7, top: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 99, 34, 212),
              borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              border: Border.all(
              color: Colors.grey, // Set the border color
              width: 1.0, // Set the border width
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: ExpenseSummary(startOfWeek: value.startOfWeekDate()?? DateTime.now())),

          SizedBox(height: 10,),
          //expense list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index)=> ExpenseTile(
              name: value.getAllExpenseList()[index].name,
              amount: value.getAllExpenseList()[index].amount,
              dateTime: value.getAllExpenseList()[index].dateTime,
              deleteTapped: (p0)=>deleteExpense(value.getAllExpenseList()[index]),
          )),
        ],
      )
    ),
    );
  }
}