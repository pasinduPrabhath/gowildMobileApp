// ignore: file_names
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('GoWild'),
      ),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        buttonBackgroundColor: Theme.of(context).colorScheme.onSecondary,
        height: 50,
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
