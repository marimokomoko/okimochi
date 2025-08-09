import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/editor_screen.dart';

void main() {
  runApp(const OkimochiApp());
}

class OkimochiApp extends StatelessWidget {
  const OkimochiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xFFFFE8F2);
    final accent = const Color(0xFFFD8FB2);

    final textTheme = GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme);

    return MaterialApp(
      title: 'okimochi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          primary: accent,
          secondary: const Color(0xFFB4E1FF),
        ),
        scaffoldBackgroundColor: baseColor,
        useMaterial3: true,
        textTheme: textTheme,
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: baseColor,
          foregroundColor: Colors.black87,
          centerTitle: true,
          titleTextStyle: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 2,
        ),
      ),
      routes: {
        '/': (_) => const HomeScreen(),
        EditorScreen.route: (_) => const EditorScreen(),
      },
    );
  }
}
