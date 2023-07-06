import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'navigationbar_screens/search_screen/search_screen.dart';
import 'navigationbar_screens/add_screen/add_screen.dart';
import 'navigationbar_screens/message_screen/message_screen.dart';
import 'navigationbar_screens/profile_screen/profile_screen.dart';
import './navigationbar_screens/home_screen/home_screen.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({super.key});

  @override
  State<ScreenController> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  final String imageUrl =
      'https://cdn.creatureandcoagency.com/uploads/2014/09/leopard-facts-10-1.jpg';
  final screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AddScreen(),
    const MessageScreen(),
    const ProfileScreen(),
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
          Icon(Icons.search,
              size: 30, color: Theme.of(context).colorScheme.background),
          Icon(Icons.add,
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
