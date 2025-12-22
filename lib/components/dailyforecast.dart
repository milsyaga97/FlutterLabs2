import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  final int minTemp;
  final int maxTemp;
  final int temp;
  final int date;
  final String monthName;
  final String shortDayName;

  const DailyForecast({
    super.key,
    required this.minTemp,
    required this.maxTemp,
    required this.temp,
    required this.date,
    required this.monthName,
    required this.shortDayName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${date} ${monthName}, ${shortDayName}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: .w800,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    '${temp}°C',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              Spacer(),
              minTemp == 0
                  ? SizedBox.shrink()
                  : Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'Мин. ${minTemp}°C',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: .w600,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ),
              maxTemp == 0
                  ? SizedBox.shrink()
                  : Card(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'Макс. ${maxTemp}°C',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: .w600,
                            color: Theme.of(
                              context,
                            ).colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
