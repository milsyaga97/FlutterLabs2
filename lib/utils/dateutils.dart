class DateUtilites {
  static int nowDay = DateTime.now().day;
  static int nowMonth = DateTime.now().month;
  static int nowYear = DateTime.now().year;

  static int startDayOnWeek(int year, int month) {
    return DateTime(year, month, 1).weekday;
  }

  static int getDaysFromMonth(int year, int month) {
    var nextMonth = (month == 12)
        ? DateTime(year + 1, 1, 1)
        : DateTime(year, month + 1, 1);
    var lastDayOfMonth = nextMonth.subtract(Duration(days: 1));
    return lastDayOfMonth.day;
  }
}
