import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpence extends StatefulWidget {
  const NewExpence({super.key, required this.onAddExpense});
  final void Function(
          String title, double amount, DateTime dateTime, Category category)
      onAddExpense;

  @override
  State<NewExpence> createState() => _NewExpenceState();
}

class _NewExpenceState extends State<NewExpence> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _saveExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content:
              const Text("Please enter valid title, amount, date and category"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    } else {
      widget.onAddExpense(
          _titleController.text,
          double.tryParse(_amountController.text)!,
          _selectedDate!,
          _selectedCategory);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                  ),
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
                        ? "No Date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final firstDate = DateTime(2000);
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: firstDate,
                          lastDate: now,
                        );
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: _saveExpense,
                child: const Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
