import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expense;
  final void Function(Expense expense) expenseRemove;
  const ExpenseList(
      {super.key, required this.expense, required this.expenseRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(expense[index]),
            child: ExpensesItem(expense: expense[index]),
            onDismissed: (direction) {
              // print(direction);
              expenseRemove(expense[index]);
            },
          );
        });
  }
}
