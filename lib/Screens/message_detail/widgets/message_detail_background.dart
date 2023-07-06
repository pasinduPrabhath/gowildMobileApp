import 'package:flutter/material.dart';
import 'dart:math' as math;

class MessageDetailsBackground extends StatelessWidget {
  const MessageDetailsBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.25,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(34.0)),
            ),
          ),
          Positioned(
            top: 150,
            left: -150,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 465,
                width: 473,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(152),
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: -180,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 465,
                width: 473,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(152),
                ),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
