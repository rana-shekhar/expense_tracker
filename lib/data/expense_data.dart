import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/main.dart';

class ExpenseData {
  // list of expanse
  List<ExpenseItem> overallExpanseList = [];

  //get expanse list
  List<ExpenseItem> getAllExpanseList() {
    return overallExpanseList;
  }

  //add new expanse
  void addNewExpanse(ExpenseItem newExpanse) {
    overallExpanseList.add(newExpanse);
  }

  //delete expanse
  void deleteExpanse(ExpanseItem expanse) {
    overallExpanseList.remove(expanse);
  }

  //get weekday from a datetime object
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

  //get the data for the start of the week( sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    // get todays date

    DateTime today = DateTime.now();
    // get backward from today to sunday

    for (var i = 0; i < 7; i++) {
      if (getDayTime(today.subtract(duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpanseSummary() {
    Map<String, double> dailyExpanseSummary = {
      // date : amount total for day
    };
    for (var expanse in overallExpanseList) {
      String date = convertDateTimeToString(expanse.dateTime);
      double amount = double.parse(expanse.amount);

      if (dailyExpanseSummary.containsKey(date)) {
        double currentAmount = dailyExpanseSummary[date]!;
        currentAmount += amount;
        dailyExpanseSummary[date] = currentAmount;
      } else {
        dailyExpanseSummary.addAll({date: amount});
      }
    }
    return dailyExpanseSummary;
  }
}
