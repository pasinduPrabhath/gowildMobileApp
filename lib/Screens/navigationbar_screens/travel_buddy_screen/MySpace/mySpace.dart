import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/MySpace/widgets/myInterestShow.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/MySpace/widgets/myInvitationShow.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/MySpace/widgets/myTripsShow.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/widgets/requestShowCard.dart';

import 'createNewTravelBuddyInvite.dart';

class MySpaceScreen extends StatefulWidget {
  const MySpaceScreen({Key? key}) : super(key: key);

  @override
  State<MySpaceScreen> createState() => _MySpaceScreenState();
}

class _MySpaceScreenState extends State<MySpaceScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Space'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.post_add_sharp),
                    SizedBox(
                      width: 5,
                    ),
                    Text('My Invitations', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(
                      width: 5,
                    ),
                    Text('My Interests', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.planeDeparture,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'My Trips',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MyInvitationsShowView(size: size),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  MyInterestShowCard(size: size),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  MyTripsShowView(size: size),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateNewTravelBuddyInvite(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
