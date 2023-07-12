import 'package:expense_tracker/add_expense.dart';
import 'package:flutter/material.dart';
import 'models/expense.dart';
import 'expense_list.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});
  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> expenses = <Expense>[
    Expense(
        title: 'Dinner',
        amount: 19.90,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Cinema',
        amount: 15.40,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Groceries',
        amount: 87.00,
        date: DateTime.now(),
        category: Category.groceries),
    Expense(
      title: 'Taxi',
      amount: 10.00,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  // method to show add expense bottom sheet
  void _showAddExpense() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddExpense(addExpense: _addExpense),
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Expenses'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpense,
        tooltip: 'Add expense',
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: false,
      body: ExpenseList(expenses: expenses),
    );
  }
}
