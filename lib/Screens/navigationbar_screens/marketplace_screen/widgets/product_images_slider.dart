import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImagesSlider extends StatelessWidget {
  final List<String> imageUrls;

  const ProductImagesSlider({Key? key, required this.imageUrls})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> imageWidgets = imageUrls.map((url) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/placeholder.png',
          image: url,
          fit: BoxFit.fitHeight,
        ),
      );
    }).toList();

    if (imageUrls.isNotEmpty) {
      return ImageSlideshow(
        indicatorColor: Colors.blue,
        height: 300,
        autoPlayInterval: 2000,
        indicatorRadius: 4,
        isLoop: true,
        children: imageWidgets,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
