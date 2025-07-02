import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider()..loadPreferences(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    
    // Colores personalizados para texto
    final Color textColor = theme.isDarkTheme ? Colors.white : Colors.black;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Configuración con SharedPreferences',
      
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: theme.primaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: theme.fontSize,
            color: textColor, // Color claro
          ),
        ),
      ),
      
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: theme.primaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: theme.fontSize,
            color: textColor, // Color oscuro
          ),
        ),
      ),
      
      themeMode: theme.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      
      routes: {
        '/': (_) => const HomeScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
      initialRoute: '/',
    );
  }
}
