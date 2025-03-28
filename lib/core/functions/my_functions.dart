class MyFunctions {
  MyFunctions._();

  static DateTime extractDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
