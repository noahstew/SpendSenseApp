import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  Expense({
    required this.title,
    required this.price,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double price;
  final DateTime date;
}
