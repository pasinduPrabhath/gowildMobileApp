import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -340,
              left: 40,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  height: size.height * 0.80,
                  width: size.width * 1.2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(152.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -390,
              left: 40,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  height: size.height * 0.80,
                  width: size.width * 1.2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(152.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -440,
              left: 40,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  height: size.height * 0.80,
                  width: size.width * 1.2,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(152.0),
                  ),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
