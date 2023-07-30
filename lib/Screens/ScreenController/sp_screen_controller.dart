import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../navigationbar_screens/profile_screen/serviceProviderProfileView/firstPersonSPView/service_provider_profile_screen.dart';

import '../navigationbar_screens/marketplace_screen/marketplace_screen.dart';
import '../navigationbar_screens/message_screen/message_screen.dart';
// import '../navigationbar_screens/profile_screen/clientProfileView/firstPersonView/profile_screen.dart';
import '../navigationbar_screens/home_screen/home_screen.dart';
import '../navigationbar_screens/travel_buddy_screen/travel_buddy_main_screen.dart';

class SpScreenController extends StatefulWidget {
  const SpScreenController({super.key});

  @override
  State<SpScreenController> createState() => _SpScreenControllerState();
}

class _SpScreenControllerState extends State<SpScreenController> {
  final String imageUrl =
      'https://cdn.creatureandcoagency.com/uploads/2014/09/leopard-facts-10-1.jpg';
  final screens = [
    const HomeScreen(),
    const TravelBuddyMainScreen(),
    const MarketPlaceScreen(),
    const MessageScreen(),
    const ServiceProviderProfileScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(kToolbarHeight),
      //   child: CustomizedAppBar(),
      // ),
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        height: 50,
        index: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        letIndexChange: (value) => true,
        items: <Widget>[
          Icon(Icons.home,
              size: 30, color: Theme.of(context).colorScheme.background),
          Icon(Icons.person_search_rounded,
              size: 30, color: Theme.of(context).colorScheme.background),
          Icon(Icons.shopping_bag,
              size: 30, color: Theme.of(context).colorScheme.background),
          Icon(Icons.message_rounded,
              size: 30, color: Theme.of(context).colorScheme.background),
          Icon(Icons.account_circle,
              size: 30, color: Theme.of(context).colorScheme.background),
        ],
      ),
    );
  }
}
