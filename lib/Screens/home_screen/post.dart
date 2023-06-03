import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String imageUrl;
  final int likes;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;

  const Post({
    Key? key,
    required this.imageUrl,
    required this.likes,
    required this.onLikePressed,
    required this.onCommentPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: onLikePressed,
            ),
            Text('$likes'),
            IconButton(
              icon: Icon(Icons.comment),
              onPressed: onCommentPressed,
            ),
          ],
        ),
      ],
    );
  }
}
