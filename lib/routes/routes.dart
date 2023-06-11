import 'package:flutter/material.dart';
import '../Screens/home_screen/feed_screen.dart';
import '../screens/registartion_screen/registration_screen.dart';
import '../Screens/admin/dashboard_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String registration = '/registration';
  static const String adminDashboard = '/admin_dashboard';
  static const String feed = '/feed';

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.registration: (context) => const RegistrationScreen(),
    AppRoutes.feed: (context) => const FeedScreen(),
    AppRoutes.adminDashboard: (context) => DashBoard(),
  };
}
