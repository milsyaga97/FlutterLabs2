import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/weatherpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/providers/weatherprovider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('ru_RU');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('ru', 'RU')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          textTheme: GoogleFonts.robotoTextTheme().apply(
            fontFamily: 'googleSans',
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 101, 191, 243),
          ),
        ),
        home: WeatherPage(),
      ),
    );
  }
}
