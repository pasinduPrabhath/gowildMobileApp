import 'package:flutter/material.dart';
import 'package:gowild/Screens/homeScreen.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String registration = '/registration';
  static const String homeScreen = '/homefeed';

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const RegistrationScreen(),
    AppRoutes.homeScreen: (context) => const HomeScreen(),
    AppRoutes.registration: (context) => const RegistrationScreen(),
  };
}
