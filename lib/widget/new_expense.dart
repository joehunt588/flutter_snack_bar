import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddEExpense});
  final void Function(Expense expense) onAddEExpense;
  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  // var _enterTitle = '';
  // void _saveTitleInput(String input) {
  //   _enterTitle = input;
  // }

  //handling text input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final dateSelect = await showDatePicker(
        context: context,
        helpText: 'Pilih Date Johan',
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = dateSelect;
    });
  }

  Category _selectedCategory = Category.leisure;

  void _submitExpenseDataForm() {
    final enteramount = double.tryParse(
        _amountController.text); //change _amountController to int
    final ammountIsInvalid = enteramount == null ||
        enteramount <= 0; //condition enteramount null or below 0

    //.trim() to remove white empty space when submit
    if (_titleController.text.trim().isEmpty ||
        ammountIsInvalid ||
        _selectedDate == null) {
      //show error
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Invalid Input"),
              content: Text("Enter valid parameter"),
              actions: [
                TextButton(
                  onPressed: () {
                    return Navigator.pop(ctx);
                  },
                  child: Text('Okay'),
                )
              ],
            );
          });
      return;
    } else {}
    widget.onAddEExpense(Expense(
        title: _titleController.text,
        amount: enteramount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context); //close dialog after submit
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),//fromLTRB mean padding left top right bottom 
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            // onChanged: (value) => _saveTitleInput(value),
            maxLength: 50,
            // keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  // onChanged: (value) => _saveTitleInput(value),
                  maxLength: 5,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Amount'), prefixText: 'RM '),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "No Date"
                        : formaterDate.format(_selectedDate!)),
                    IconButton(
                        onPressed: () {
                          return _presentDatePicker();
                        },
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ), // create space between button and dropdown widget
          Row(
            children: [
              DropdownButton(
                  //dropdown dont have controller so cant add TextEditingController()
                  value: _selectedCategory, //show dropdown value
                  items: Category.values
                      .map(
                        (e) => //because category enum is iterable list put .toList()
                            DropdownMenuItem(
                          value: e,
                          child: Text(e.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      //if value not select
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                  onPressed: () {
                    //close modal
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    // print(_titleController.text);
                    _submitExpenseDataForm();
                  },
                  child: const Text("Submit"))
            ],
          )
        ],
      ),
    );
  }
}
