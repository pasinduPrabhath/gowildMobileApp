import 'package:flutter/material.dart';
// import '../Screens/home_screen/feed_screen.dart';
import '../Screens/ScreenController/client_screen_controller.dart';
import '../Screens/ScreenController/sp_screen_controller.dart';
import '../screens/registration_screen/registration_screen.dart';
import '../Screens/registration_screen/test_upload.dart';

class AppRoutes {
  static const String home = '/';
  static const String registration = '/registration';
  static const String adminDashboard = '/admin_dashboard';
  static const String feed = '/feed';
  static const String test = '/test';
  static const String clientScreenController = '/client_screen_controller';
  static const String spScreenController = '/sp_screen_controller';
  static const String marketProductDescription = '/marketProductDescription';

  static final Map<String, WidgetBuilder> routes = {
    AppRoutes.registration: (context) => const RegistrationScreen(),
    // AppRoutes.feed: (context) => const FeedScreen(),
    AppRoutes.test: (context) => const ImageUpload(),
    AppRoutes.clientScreenController: (context) =>
        const ClientScreenController(),
    AppRoutes.spScreenController: (context) => const SpScreenController(),
    // AppRoutes.marketProductDescription: (context) => const ProductDescription(),
  };
}
