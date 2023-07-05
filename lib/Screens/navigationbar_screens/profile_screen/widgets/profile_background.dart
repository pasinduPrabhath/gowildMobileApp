import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileBackground extends StatelessWidget {
  const ProfileBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          child,
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
                    color: Color.fromARGB(45, 104, 128, 138),
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
                    color: Color.fromARGB(46, 116, 156, 173),
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
                  color: Color.fromARGB(146, 18, 165, 190).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
