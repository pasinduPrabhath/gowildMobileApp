import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      // brightness: Brightness.dark,
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 45.0,
          color: Colors.orange,
        ),
        labelLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        titleMedium: TextStyle(fontFamily: 'NotoSans'),
        bodyMedium: TextStyle(fontFamily: 'NotoSans'),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.orange)
          .copyWith(outline: Color(0xFF419B63)) //appbar color
          .copyWith(
              background: Color.fromARGB(255, 20, 20, 20)) //background color
          .copyWith(onPrimary: Color.fromARGB(255, 254, 255, 255)) //text color
          .copyWith(onSecondary: Color.fromARGB(255, 81, 128, 99)),
    );

    return MaterialApp(
      title: 'GoWild',
      theme: theme,
      home: const LoginScreen(),
    );
  }
}
