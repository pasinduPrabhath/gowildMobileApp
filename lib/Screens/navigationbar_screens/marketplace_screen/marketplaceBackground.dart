import 'package:flutter/material.dart';
import 'dart:math' as math;

class MarketplaceBackground extends StatelessWidget {
  const MarketplaceBackground({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -20,
            left: -400,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Container(
                height: 469,
                width: 680,
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(148, 62, 134, 168).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: -400,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Container(
                width: 504,
                height: 564,
                decoration: BoxDecoration(
                  // color: Color.fromARGB(48, 62, 134, 168).withOpacity(0.1),
                  border: Border.all(
                    width: 1.0,
                    color: const Color.fromARGB(46, 116, 156, 173)
                        .withOpacity(0.6),
                  ),
                  borderRadius: BorderRadius.circular(152.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: -400,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Container(
                width: 453,
                height: 537,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: const Color.fromARGB(46, 116, 156, 173)
                        .withOpacity(0.6),
                  ),
                  borderRadius: BorderRadius.circular(152.0),
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
