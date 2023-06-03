import 'package:flutter/material.dart';
import 'package:gowild/Screens/home_screen/homeScreen.dart';
import '../screens/registartion_screen/registration_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String registration = '/registration';
  static const String homeScreen = '/homeScreen';

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.homeScreen: (context) => HomeScreen(),
    AppRoutes.registration: (context) => const RegistrationScreen(),
  };
}
