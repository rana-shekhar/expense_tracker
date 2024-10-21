import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/expense_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final newExpenseNameController = TextEditingController();
final newExpenseAmountController = TextEditingController();

class _HomePageState extends State<HomePage> {
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense name
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(hintText: 'Expense Name'),
            ),
            // Expense amount
            TextField(
              controller: newExpenseAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Expense Amount'),
            ),
          ],
        ),
        actions: [
          // Save button
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          // Cancel button
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Save new expense
  void save() {
    // Create new expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );

    // Add new expense to list
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    // Clear text fields
    newExpenseNameController.clear();
    newExpenseAmountController.clear();

    // Close the dialog
    Navigator.of(context).pop();
  }

  // Cancel adding expense
  void cancel() {
    // Clear text fields
    newExpenseNameController.clear();
    newExpenseAmountController.clear();

    // Close the dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),
        body: ListView(children: [
          //weekly summary
ExpenseSummary(startOfWeek: value.startOfWeekDate()),

          //expense summary
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          itemCount: value.getAllExpenseList().length,
          itemBuilder: (context, index) => ExpenseTile(
            name: value.getAllExpenseList()[index].name,
          amount: value.getAllExpenseList()[index].amount, 
          dateTime: value.getAllExpenseList()[index].dateTime),

           
          
        ),
        ],)
      ),
    );
  }
}
