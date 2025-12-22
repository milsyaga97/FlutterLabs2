class Weather {
  final Fact current;
  final List<WeatherDay> days;

  Weather({required this.current, required this.days});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      current: Fact.fromJson(json['fact']),
      days: (json['forecasts'] as List)
          .map((e) => WeatherDay.fromJson(e))
          .toList(),
    );
  }
}

class WeatherDay {
  final String date;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final List<WeatherHour> hours;

  WeatherDay({
    required this.date,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.hours,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json) {
    final hours = json['hours'] as List;

    final partsMap = json['parts'] as Map<String, dynamic>;
    final partNames = ['morning', 'day', 'evening', 'night'];

    final minTemps = partNames
        .where((name) => partsMap.containsKey(name))
        .map((name) => (partsMap[name]['temp_min'] ?? 0) as int)
        .toList();
    final maxTemps = partNames
        .where((name) => partsMap.containsKey(name))
        .map((name) => (partsMap[name]['temp_max'] ?? 0) as int)
        .toList();

    final minTemp = minTemps.isEmpty
        ? 0.0
        : minTemps.reduce((a, b) => a < b ? a : b).toDouble();
    final maxTemp = maxTemps.isEmpty
        ? 0.0
        : maxTemps.reduce((a, b) => a > b ? a : b).toDouble();

    return WeatherDay(
      date: json['date'],
      temp: json['parts']['day']['temp_avg'].toDouble(),
      minTemp: minTemp,
      maxTemp: maxTemp,
      hours: hours.map((e) => WeatherHour.fromJson(e)).toList(),
    );
  }
}

class WeatherHour {
  final String hour;
  final int temp;
  final int feelsLike;
  final int humidity;
  final int pressureMm;
  final double precMm;
  final String condition;

  WeatherHour({
    required this.hour,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressureMm,
    required this.precMm,
    required this.condition,
  });

  factory WeatherHour.fromJson(Map<String, dynamic> json) {
    return WeatherHour(
      hour: json['hour'] as String,
      temp: json['temp'] as int,
      feelsLike: json['feels_like'] as int,
      humidity: json['humidity'] as int,
      pressureMm: json['pressure_mm'] as int,
      precMm: (json['prec_mm'] ?? 0).toDouble(),
      condition: json['condition'] as String,
    );
  }
}

class Fact {
  final int temp;
  final int feelsLike;
  final int humidity;
  final int pressureMm;
  final double precMm;
  final String condition;
  final String icon;

  Fact({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressureMm,
    required this.precMm,
    required this.condition,
    required this.icon,
  });

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      temp: json['temp'] as int,
      feelsLike: json['feels_like'] as int,
      humidity: json['humidity'] as int,
      pressureMm: json['pressure_mm'] as int,
      precMm: (json['prec_mm'] ?? 0).toDouble(),
      condition: conditionDescriptions[json['condition']] ?? 'Неизвестно',
      icon: json['icon'] as String,
    );
  }
}

Map<String, String> conditionDescriptions = {
  'clear': 'Ясно',
  'partly-cloudy': 'Малооблачно',
  'cloudy': 'Облачно с прояснениями',
  'overcast': 'Пасмурно',
  'drizzle': 'Морось',
  'light-rain': 'Небольшой дождь',
  'rain': 'Дождь',
  'moderate-rain': 'Умеренно сильный дождь',
  'heavy-rain': 'Сильный дождь',
  'continuous-heavy-rain': 'Длительный сильный дождь',
  'showers': 'Ливень',
  'wet-snow': 'Дождь со снегом',
  'light-snow': 'Небольшой снег',
  'snow': 'Снег',
  'snow-showers': 'Снегопад',
  'hail': 'Град',
  'thunderstorm': 'Гроза',
  'thunderstorm-with-rain': 'Дождь с грозой',
  'thunderstorm-with-hail': 'Гроза с градом',
};
