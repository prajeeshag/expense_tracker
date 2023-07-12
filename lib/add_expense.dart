import 'package:flutter/material.dart';
import 'models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addExpense});

  final void Function(Expense) addExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  Category selectedCategory = Category.leisure;
  DateTime selectedDate = DateTime.now();

  //a getter for formatted date using intl package
  String get formattedDate => dateFormater.format(selectedDate);

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        children: <Widget>[
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            controller: amountController,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.toString(),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedCategory,
                onChanged: (category) {
                  setState(() {
                    selectedCategory = category as Category;
                  });
                },
              ),
              const Spacer(),
              Row(
                children: [
                  Text(formattedDate),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                          });
                        }
                      });
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                ),
                onPressed: () {
                  final title = titleController.text;
                  final amount = double.tryParse(amountController.text);
                  if (title.isEmpty || amount == null) {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Invalid input'),
                          content: const Text(
                              'Please enter a valid title and amount'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  final expense = Expense(
                    title: title,
                    amount: amount!,
                    date: selectedDate,
                    category: selectedCategory,
                  );
                  widget.addExpense(expense);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
