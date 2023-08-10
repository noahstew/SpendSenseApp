import 'package:extra_expenses/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:extra_expenses/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemovedItem,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Dismissible(
                key: ValueKey(
                  expenses[index],
                ),
                child: ExpenseCard(
                  expense: expenses[index],
                ),
                onDismissed: (direction) {
                  onRemovedItem(expenses[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
