import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // List of Expenses
  List<ExpenseItem> overallExpenseList = [];

  // Get the full expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // Add a new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners(); // Notify listeners after adding an expense
  }

  // Delete an expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners(); // Notify listeners after deleting an expense
  }

  // Get weekday from a DateTime object
  String getDayTime(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // Get the date for the start of the week (Sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();

    // Go backward from today to find Sunday
    for (var i = 0; i < 7; i++) {
      if (getDayTime(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
        break; // Stop searching once Sunday is found
      }
    }
    return startOfWeek!;
  }

  // Calculate daily expense summary
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime); // Corrected to `expense`
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary[date] = amount;
      }
    }

    return dailyExpenseSummary;
  }
}
