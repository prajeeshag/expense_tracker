import 'package:flutter/material.dart';
import 'models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          final Expense expense = expenses[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      expense.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      // amount in INR with 2 decimal places
                      '₹${expense.amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      // date in dd/mm/yyyy format
                      expense.formattedDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      expense.category.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
