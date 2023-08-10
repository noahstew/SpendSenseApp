import 'dart:io';

import 'package:extra_expenses/models/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:extra_expenses/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: ThemeColors.hard,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              'Please make sure a valid title, amount and date was selected'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        price: enteredAmount,
        date: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                              labelStyle: TextStyle(
                                color: ThemeColors.hard,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ThemeColors.hard,
                                ),
                              ),
                            ),
                            cursorColor: ThemeColors.hard,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            maxLength: 8,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              prefixText: "\$ ",
                              label: Text('Amount'),
                              labelStyle: TextStyle(
                                color: ThemeColors.hard,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ThemeColors.hard,
                                ),
                              ),
                            ),
                            cursorColor: ThemeColors.hard,
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                        labelStyle: TextStyle(color: ThemeColors.hard),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeColors.hard,
                          ),
                        ),
                      ),
                      cursorColor: ThemeColors.hard,
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            maxLength: 8,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              prefixText: "\$ ",
                              label: Text('Amount'),
                              labelStyle: TextStyle(
                                color: ThemeColors.hard,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ThemeColors.hard,
                                ),
                              ),
                            ),
                            cursorColor: ThemeColors.hard,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text('Add Expense'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.hard,
                              foregroundColor: ThemeColors.white),
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text('Add Expense'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: ThemeColors.hard),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
