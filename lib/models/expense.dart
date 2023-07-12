import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormater = DateFormat.yMMMd();

enum Category { food, travel, leisure, work, groceries }

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // A getter for formatted date
  String get formattedDate => dateFormater.format(date);
}
