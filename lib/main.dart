import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/weatherpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/providers/weatherprovider.dart';

void main() {
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
        supportedLocales: [Locale('ru')],
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
