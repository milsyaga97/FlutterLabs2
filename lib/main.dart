import 'package:News/pages/HomePage.dart';
import 'package:News/providers/NewsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsProvider>(
      create: (_) => NewsProvider(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('ru')],
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          textTheme: GoogleFonts.robotoTextTheme().apply(
            fontFamily: 'googleSans',
          ),
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            contrastLevel: 1,
            seedColor: const Color.fromARGB(255, 205, 211, 216),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
