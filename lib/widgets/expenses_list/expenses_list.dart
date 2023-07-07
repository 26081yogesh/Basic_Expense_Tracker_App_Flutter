import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_items_cards.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (DismissDirection direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItemsCard(expense: expenses[index]),
      ),
    );
  }
}
