// ignore: file_names
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurvedNavBar extends StatelessWidget {
  // final int selectedIndex = 0;
  final Function(int)? onItemTapped;

  const CurvedNavBar({Key? key, this.onItemTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Theme.of(context).colorScheme.onSecondary,
      height: 50,
      // index: _selectedIndex,
      onTap: onItemTapped,
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
    );
  }
}
