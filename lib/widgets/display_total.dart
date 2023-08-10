import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:extra_expenses/models/custom_theme.dart';

class DisplayTotal extends StatelessWidget {
  const DisplayTotal({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: ThemeColors.soft,
            ),
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: CircleAvatar(
                    backgroundColor: ThemeColors.debtBackground,
                    radius: 110,
                    child: Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: GoogleFonts.rubik(
                        color: ThemeColors.debt,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '...wasted recently.',
                  style: GoogleFonts.rubik(
                    color: ThemeColors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
