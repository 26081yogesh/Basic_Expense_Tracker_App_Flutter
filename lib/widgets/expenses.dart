import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 1000,
      dateTime: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Mc Donald",
      amount: 300,
      dateTime: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Adidas",
      amount: 1200,
      dateTime: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Goa Trip",
      amount: 13000,
      dateTime: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void addExpenseToTheList(
      String title, double amount, DateTime dateTime, Category category) {
    setState(() {
      _registeredExpenses.add(Expense(
          title: title,
          amount: amount,
          dateTime: dateTime,
          category: category));
    });
  }

  void removeExpenseFromTheList(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddExpenseModalOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) => NewExpence(
              onAddExpense: addExpenseToTheList,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expense Found! Start Adding Some"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpenseFromTheList,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseModalOverlay,
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text("Chart..."),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
