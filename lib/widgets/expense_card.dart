import 'package:extra_expenses/models/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:extra_expenses/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: ThemeColors.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  expense.title,
                  style: GoogleFonts.rubik(
                    color: ThemeColors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                '\$${expense.price.toStringAsFixed(2)}',
                style: GoogleFonts.rubik(
                  color: ThemeColors.debt,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
