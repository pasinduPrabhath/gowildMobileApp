import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import '../../reusable_components/side_nav_bar.dart';
import '../../reusable_components/sideDrawer.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

List<Widget> views = const [
  Center(
    child: Text('Dashboard'),
  ),
  Center(
    child: Text('Account'),
  ),
  Center(
    child: Text('Settings'),
  ),
];
int selectedIndex = 0;

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: SideDrawer(
        accountName: 'Pasindu Prabhath',
        accountEmail: 'pasinduprabhath@gmail.com',
        currentAccountPicture:
            const AssetImage('assets/images/adminProfPic.png'),
      ),
      body: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'hello',
                style: TextStyle(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('click me'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
