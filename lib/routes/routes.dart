import 'package:flutter/material.dart';
import 'package:gowild/Screens/homeScreen.dart';
import '../screens/registration_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String registration = '/registration';
  static const String homeScreen = '/homeScreen';

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.homeScreen: (context) => const HomeScreen(),
    AppRoutes.registration: (context) => const RegistrationScreen(),
  };
}
