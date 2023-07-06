import 'package:flutter/material.dart';
import 'dart:math' as math;

class MessageBackground extends StatelessWidget {
  MessageBackground({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amberAccent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 150,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 465,
                width: 473,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(152)),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 465,
                width: 473,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(152)),
              ),
            ),
          ),
          Positioned(
            top: 260,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                height: 575,
                width: 580,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(152),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
