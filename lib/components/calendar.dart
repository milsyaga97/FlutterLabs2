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
    int pastDaysStart = startDay == 1 ? 0 : pastDays - startDay;

    //расчет дней следующего месяца
    int nextDaysPos = DateUtilites.startDayOnWeek(
      selectedMonth == 12 ? selectedYear + 1 : selectedYear,
      selectedMonth == 12 ? 1 : selectedMonth + 1,
    );
    int howMuchNext = nextDaysPos != 1 ? 8 - nextDaysPos : 0;

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

    String? monthName = DateUtilites.nameOfMonth[selectedMonth];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Календарь",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: .w600,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutGrid(
          columnSizes: [1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr, 1.fr],
          rowSizes: [25.px, 80.px, 80.px, 80.px, 80.px, 80.px, 80.px, 200.px],
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
            GridPlacement(
              columnStart: 0,
              columnSpan: 7,
              rowStart: 7,
              rowSpan: 1,
              child: Column(
                crossAxisAlignment: .end,
                children: [
                  Row(
                    mainAxisAlignment: .end,
                    spacing: 5,
                    children: [
                      Expanded(
                        child: Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: Text(
                              textAlign: .center,
                              '$selectedYear',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: .w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedYear--;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Icon(Icons.arrow_back),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedYear++;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .end,
                    spacing: 5,
                    children: [
                      Expanded(
                        child: Card(
                          color: Theme.of(context).colorScheme.onPrimary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: .center,
                              '$monthName',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: .w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedMonth == 1
                                ? {selectedMonth = 12, selectedYear--}
                                : selectedMonth--;
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          iconColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: Icon(Icons.arrow_back),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedMonth == 12
                                ? {selectedMonth = 1, selectedYear++}
                                : selectedMonth++;
                          });
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          iconColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedMonth = DateUtilites.nowMonth;
                        selectedYear = DateUtilites.nowYear;
                      });
                    },
                    child: Icon(Icons.restore),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      iconColor: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
