import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItemsCard extends StatelessWidget {
  const ExpenseItemsCard({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(height: 5),
            Row(
              children: [
                Text("Rs ${expense.amount.toStringAsFixed(2)}"),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.getFormattedDate().toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
