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

  //get the data for the start of the week( sunday)

  //
}
