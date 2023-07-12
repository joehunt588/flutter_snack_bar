import 'package:expenses_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];


  void _openAddExpensesOverlay(){
    showModalBottomSheet(isScrollControlled: true,context: context, builder: (ctx){
      // dialog form
      return NewExpenses(onAddEExpense:_addExpense);
    });
  }

  void _addExpense(Expense expense){

    setState(() {
      // print(expense.title);
      _registeredExpenses.add(expense);
    });
    
  }

  void _removeExpense(Expense expense){
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(child: Text("No Expenses found"),);
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpenseList(expense: _registeredExpenses,expenseRemove: _removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Expenses Tracker"),
        actions: [IconButton(onPressed: () {
          _openAddExpensesOverlay();
        }, icon: const Icon(Icons.add))],
        
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
