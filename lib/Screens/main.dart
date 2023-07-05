import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../routes/routes.dart';
import './login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      unselectedWidgetColor: const Color.fromARGB(255, 165, 160, 160),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 45.0,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        labelLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),
        labelMedium: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          fontSize: 30,
          color: Color.fromARGB(255, 12, 12, 12),
        ),
        titleMedium: TextStyle(
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.w800,
          fontSize: 23,
          color: Color.fromARGB(255, 14, 13, 13),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'NotoSans',
          color: Colors.white,
        ),
        // titleLarge: TextStyle(fontSize: 10.0),
        // displayLarge: TextStyle(fontSize: 10.0),
        displayMedium: TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 5, 5, 5),
        ),
        titleSmall: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(255, 14, 13, 13),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          // .copyWith(brightness: )
          .copyWith(secondary: Colors.orange)
          .copyWith(
              outline: const Color.fromARGB(255, 13, 158, 61)) //appbar color
          .copyWith(
              background: const Color.fromARGB(
                  255, 39, 38, 38)) //background color dont change
          .copyWith(
              primary: const Color.fromARGB(255, 52, 136, 80)) //primary color
          .copyWith(
              onPrimary: const Color.fromARGB(255, 254, 255, 255)) //text color
          .copyWith(onSecondary: const Color.fromARGB(255, 15, 119, 55)),
    );

    return MaterialApp(
      title: 'GoWild',
      theme: theme,
      home: const LoginScreen(),
      routes: AppRoutes.routes,
    );
  }
}
