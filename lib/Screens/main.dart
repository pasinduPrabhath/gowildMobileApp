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
          fontSize: 20.0,
          color: Color.fromARGB(148, 12, 12, 12),
        ),
        labelLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Color.fromARGB(255, 19, 18, 18),
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
          fontSize: 20,
          color: Color.fromARGB(255, 14, 13, 13),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'NotoSans',
          color: Color.fromARGB(255, 22, 21, 21),
        ),
        labelSmall: TextStyle(
          fontFamily: 'NotoSans',
          color: Color.fromARGB(255, 22, 21, 21),
          fontSize: 20,
        ),
        // titleLarge: TextStyle(fontSize: 10.0),
        displayLarge: TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
        displayMedium: TextStyle(
          fontSize: 15.0,
          color: Color.fromARGB(255, 5, 5, 5),
        ),
        titleSmall: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(255, 14, 13, 13),
        ),
        bodySmall: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 14, 13, 13),
          fontSize: 17,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          // .copyWith(brightness: )
          .copyWith(
              secondary: const Color.fromARGB(
                  255, 218, 238, 247)) //background widget color
          .copyWith(
              outline: const Color.fromARGB(
                  95, 186, 217, 236)) //background outline color
          .copyWith(background: const Color.fromARGB(255, 20, 64, 100))
          .copyWith(primary: const Color.fromARGB(209, 151, 210, 224))
          .copyWith(
              onPrimary: const Color.fromARGB(255, 254, 255, 255)) //text color
          .copyWith(onSecondary: const Color.fromARGB(255, 74, 128, 150))
          .copyWith(onBackground: const Color.fromARGB(255, 71, 170, 201)),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoWild',
      theme: theme,
      home: const LoginScreen(),
      routes: AppRoutes.routes,
    );
  }
}
