import 'package:flutter/material.dart';
import '../../../reusable_components/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final String imageUrl =
      'https://cdn.creatureandcoagency.com/uploads/2014/09/leopard-facts-10-1.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      body: Stack(
        children: [
          ListView(
            children: [
              PostCard(imageUrl: imageUrl),
              const PostCard(
                  imageUrl:
                      'https://w0.peakpx.com/wallpaper/837/869/HD-wallpaper-leopard-grin-predator-beast-wildlife.jpg'),
            ],
          ),
        ],
      ),
    );
  }
}
