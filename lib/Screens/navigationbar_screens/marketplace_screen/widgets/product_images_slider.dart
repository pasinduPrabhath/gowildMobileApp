import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImagesSlider extends StatelessWidget {
  const ProductImagesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Colors.blue,
      height: 300,
      autoPlayInterval: 2000,
      indicatorRadius: 4,
      isLoop: true,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/market/p1.png',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/market/p2.png',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/market/p1.png',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/market/p2.png',
          ),
        ),
      ],
    );
  }
}
