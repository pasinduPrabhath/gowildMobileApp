import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.outline,
        title: const Text('GoWild'),
      ),
      body: const Column(
        children: [],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.outline,
        backgroundColor: const Color.fromARGB(0, 129, 5, 5),
        buttonBackgroundColor: Theme.of(context).colorScheme.onSecondary,
        height: 50,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.search, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.account_circle, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
