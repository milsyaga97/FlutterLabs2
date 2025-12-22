import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/components/dailyforecast.dart';
import 'package:weather/providers/weatherprovider.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();

    final weathercontext = context.read<WeatherProvider>();
    Future.microtask(
      () => weathercontext.fetchWeather(
        weathercontext.citylist[weathercontext.city]![0],
        weathercontext.citylist[weathercontext.city]![1],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weathercontext = context.watch<WeatherProvider>();
    final nowtime = DateTime.now();
    final shortMonthName = DateFormat.MMM('ru').format(nowtime);
    final dayName = DateFormat.EEEE('ru').format(nowtime);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Погода",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: .w800,
              ),
            ),
            Spacer(),
            MenuAnchor(
              menuChildren: [
                for (var cityName in weathercontext.citylist.keys)
                  MenuItemButton(
                    onPressed: () {
                      weathercontext.changeCity(cityName);
                    },
                    child: Text(cityName),
                  ),
              ],
              builder: (context, controller, child) => ElevatedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_location_sharp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      weathercontext.city,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: .w800,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  controller.open();
                },
              ),
            ),
          ],
        ),
      ),
      body: weathercontext.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                spacing: 0,
                mainAxisAlignment: .start,
                crossAxisAlignment: .center,
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: 5,
                        children: [
                          Text(
                            weathercontext.weatherData != null
                                ? '${nowtime.day} ${shortMonthName}, ${dayName}'
                                : 'Дата',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: .w800,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: .end,
                            spacing: 10,
                            children: [
                              weathercontext.weatherData != null
                                  ? SvgPicture.network(
                                      'https://yastatic.net/weather/i/icons/funky/dark/${weathercontext.weatherData!.current.icon}.svg',
                                      width: 64,
                                      height: 64,
                                    )
                                  : Icon(Icons.cloud, size: 48),
                              Text(
                                weathercontext.weatherData != null
                                    ? '${weathercontext.weatherData!.current.temp}°C'
                                    : 'Температура',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: .w500,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: .end,
                            children: [
                              Text(
                                weathercontext.weatherData != null
                                    ? weathercontext
                                          .weatherData!
                                          .current
                                          .condition
                                    : 'condition',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontWeight: .w800,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: .end,
                            spacing: 15,
                            children: [
                              Text(
                                weathercontext.weatherData != null
                                    ? 'Мин: ${weathercontext.weatherData!.days[0].minTemp}°C'
                                    : 'min_temp',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                weathercontext.weatherData != null
                                    ? 'Макс: ${weathercontext.weatherData!.days[0].maxTemp}°C'
                                    : 'max_temp',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 1,
                            runSpacing: 1,
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    weathercontext.weatherData != null
                                        ? 'Ощущается как: ${weathercontext.weatherData!.current.feelsLike}°C'
                                        : 'feels_like',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Theme.of(
                                  context,
                                ).colorScheme.tertiaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Влажность: ${weathercontext.weatherData != null ? weathercontext.weatherData!.current.humidity.toString() : "humidity"}%',
                                  ),
                                ),
                              ),
                              Card(
                                color: Theme.of(
                                  context,
                                ).colorScheme.tertiaryContainer,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'Атм. давление: ${weathercontext.weatherData != null ? weathercontext.weatherData!.current.pressureMm.toString() : "pressure"} мм рт. ст.',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (weathercontext.weatherData != null)
                                  ...weathercontext.weatherData!.days[0].hours
                                      .map(
                                        (hour) => Card(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${hour.hour} ч',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer,
                                                  ),
                                                ),
                                                Text(
                                                  '${hour.temp}°C',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        if (weathercontext.weatherData != null)
                          ...weathercontext.weatherData!.days
                              .skip(1)
                              .map(
                                (day) => DailyForecast(
                                  minTemp: day.minTemp.toInt(),
                                  maxTemp: day.maxTemp.toInt(),
                                  temp: day.temp.toInt(),
                                  date: int.parse(day.date.split('-')[2]),
                                  monthName: DateFormat.MMM(
                                    'ru',
                                  ).format(DateTime.parse(day.date)),
                                  shortDayName: DateFormat.E(
                                    'ru',
                                  ).format(DateTime.parse(day.date)),
                                ),
                              ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
