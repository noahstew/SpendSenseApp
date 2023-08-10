import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:extra_expenses/models/custom_theme.dart';
import 'package:extra_expenses/models/expense.dart';
import 'package:extra_expenses/widgets/display_total.dart';
import 'package:extra_expenses/widgets/expense_list.dart';
import 'package:extra_expenses/screens/add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [
    Expense(
      title: 'Swipe me',
      price: 6.99,
      date: DateTime.now(),
    ),
  ];
  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(
          'Item was removed.',
          style: TextStyle(
            color: ThemeColors.white,
          ),
        ),
        backgroundColor: ThemeColors.hard,
        action: SnackBarAction(
            label: 'Undo',
            textColor: ThemeColors.white,
            onPressed: () {
              setState(() {
                expenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: ThemeColors.soft,
      context: context,
      builder: (ctx) => AddExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.price;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SpendSense',
          style: GoogleFonts.rubik(
            color: ThemeColors.hard,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: ThemeColors.primary,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          DisplayTotal(total: totalExpenses),
          totalExpenses == 0
              ? const Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Icon(
                      Icons.list_alt_outlined,
                      size: 60,
                      color: ThemeColors.hard,
                    ),
                    Text(
                      'There is no expenses added yet!',
                      style: TextStyle(
                        color: ThemeColors.hard,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(Tap the + to add some)',
                      style: TextStyle(
                        color: ThemeColors.hard,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : ExpenseList(
                  expenses: expenses,
                  onRemovedItem: _removeExpense,
                ),
        ],
      ),
    );
  }
}
