import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
  super.key, 
  required this.name,
  required this.amount,
  required this.dateTime,
  required this.deleteTapped,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), 
      children: [
        SlidableAction(onPressed: deleteTapped,
        icon: Icons.delete_outline,
        backgroundColor: Colors.red,)
      ]),
      child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString()+'/'+dateTime.month.toString()+'/'+dateTime.year.toString()),
        trailing: Text(amount),
      ),
    );
  }
}