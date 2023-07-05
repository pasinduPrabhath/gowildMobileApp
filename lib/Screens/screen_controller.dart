import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../Screens/navigationbar_screens/home_screen/feed_screen.dart';
import 'navigationbar_screens/search_screen/search_screen.dart';
import 'navigationbar_screens/add_screen/add_screen.dart';
import 'navigationbar_screens/notification_screen/notification_screen.dart';
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
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      appBar: AppBar(
        flexibleSpace: Container(
          // height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(235, 141, 228, 240),
                Color.fromARGB(235, 168, 230, 238),
                Color.fromARGB(235, 163, 211, 218),
                Color.fromARGB(235, 205, 235, 240),
                Color.fromARGB(235, 195, 227, 231),
                Color.fromARGB(235, 197, 223, 226),
                Color.fromARGB(235, 205, 231, 235),
                Color.fromARGB(235, 213, 238, 241),
                Color.fromARGB(235, 205, 231, 235),
                Color.fromARGB(235, 227, 234, 235),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'GoWild',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.messenger_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              )),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.onSecondary,
        height: 50,
        index: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        letIndexChange: (value) => true,
        items: <Widget>[
          Icon(Icons.home,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
          Icon(Icons.search,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
          Icon(Icons.add,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
          Icon(Icons.favorite,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
          Icon(Icons.account_circle,
              size: 30, color: Theme.of(context).colorScheme.onPrimary),
        ],
      ),
    );
  }
}
