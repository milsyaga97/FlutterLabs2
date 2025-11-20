import 'package:calendar/components/dayinmonth.dart';
import 'package:calendar/components/dayoutmonth.dart';
import 'package:calendar/components/titleday.dart';
import 'package:calendar/utils/dateutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int selectedYear = DateUtilites.nowYear;
  int selectedMonth = DateUtilites.nowMonth;

  @override
  Widget build(BuildContext context) {
    int days = DateUtilites.getDaysFromMonth(selectedYear, selectedMonth);

    //расчет дней предыдущего месяца (сколько вставить)
    int startDay = DateUtilites.startDayOnWeek(selectedYear, selectedMonth);
    int pastDays = DateUtilites.getDaysFromMonth(
      selectedMonth != 1 ? selectedYear : selectedYear - 1,
      selectedMonth != 1 ? selectedMonth - 1 : 12,
    );
    int pastDaysStart = pastDays - startDay;

    //расчет дней следующего месяца
    int nextDaysPos = DateUtilites.startDayOnWeek(
      selectedMonth == 12 ? selectedYear + 1 : selectedYear,
      selectedMonth == 12 ? 1 : selectedMonth + 1,
    );
    int howMuchNext = 8 - nextDaysPos;

    //вставка дней предыдущего месяца
    List<Widget> pastDaysWidgets = .generate(startDay - 1, (index) {
      pastDaysStart++;
      return Dayoutmonth(day: pastDaysStart);
    });

    //вставка дней текущего месяца
    List<Widget> daysWidgets = .generate(days, (index) {
      bool nowDay = false;
      if (selectedYear == DateUtilites.nowYear &&
          selectedMonth == DateUtilites.nowMonth &&
          index + 1 == DateUtilites.nowDay) {
        nowDay = true;
      }
      return Dayinmonth(day: index, nowDay: nowDay);
    });

    //вставка дней следующего месяца
    List<Widget> nextDaysWidgets = .generate(howMuchNext, (index) {
      return Dayoutmonth(day: index);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Календарь",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutGrid(
          columnSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
          rowSizes: [
            0.2.fr,
            0.3.fr,
            0.3.fr,
            0.3.fr,
            0.3.fr,
            0.3.fr,
            1.fr,
            1.fr,
          ],
          children: [
            TitleDay(title: 'Пн.'),
            TitleDay(title: "Вт."),
            TitleDay(title: "Ср."),
            TitleDay(title: "Чт."),
            TitleDay(title: "Пт."),
            TitleDay(title: "Сб."),
            TitleDay(title: "Вс."),
            ...pastDaysWidgets,
            ...daysWidgets,
            ...nextDaysWidgets,
          ],
        ),
      ),
    );
  }
}
