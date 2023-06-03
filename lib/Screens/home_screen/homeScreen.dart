// ignore: file_names
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'post.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Post> posts = [
    Post(
      imageUrl: 'https://picsum.photos/200',
      likes: 10,
      onLikePressed: () {},
      onCommentPressed: () {},
    ),
    Post(
      imageUrl: 'https://picsum.photos/200',
      likes: 20,
      onLikePressed: () {},
      onCommentPressed: () {},
    ),
    Post(
      imageUrl: 'https://picsum.photos/200',
      likes: 30,
      onLikePressed: () {},
      onCommentPressed: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('GoWild'),
      ),
      body: Visibility(
        visible: _selectedIndex == 0,
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return posts[index];
          },
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        buttonBackgroundColor: Theme.of(context).colorScheme.onSecondary,
        height: 50,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
