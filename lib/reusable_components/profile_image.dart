import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.radius,
  });
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.0,
          color: Colors.black,
        ),
      ),
      child: CircleAvatar(
        backgroundImage: const NetworkImage(
            'https://funkylife.in/wp-content/uploads/2021/06/whatsapp-dp-pic-24-scaled.jpg'),
        radius: radius,
      ),
    );
  }
}
