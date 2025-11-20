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

  static Map<int, String> nameOfMonth = {
    1: 'январь',
    2: 'февраль',
    3: 'март',
    4: 'апрель',
    5: 'май',
    6: 'июнь',
    7: 'июль',
    8: 'август',
    9: 'сентябрь',
    10: 'октябрь',
    11: 'ноябрь',
    12: 'декабрь',
  };
}
