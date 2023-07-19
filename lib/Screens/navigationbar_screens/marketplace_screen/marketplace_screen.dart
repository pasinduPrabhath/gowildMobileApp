import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/widgets/grid_items.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'marketplaceBackground.dart';

class MarketPlaceScreen extends StatelessWidget {
  const MarketPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MarketplaceBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Marketplace',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 14, 14, 14))),
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: WidgetStyleContainer(
                        size: size,
                        icon: Icons.search,
                        text: 'Search',
                        width: size.width * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    WidgetStyleBottomContainer(
                      size: size,
                      icon: const FaIcon(FontAwesomeIcons.car).icon,
                      text: 'Safari',
                      width: size.width * 0.17,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    WidgetStyleBottomContainer(
                      size: size,
                      icon: const FaIcon(FontAwesomeIcons.camera).icon,
                      text: 'Camera',
                      width: size.width * 0.2,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    WidgetStyleBottomContainer(
                      size: size,
                      icon: const FaIcon(FontAwesomeIcons.photoFilm).icon,
                      text: 'Photos',
                      width: size.width * 0.2,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    WidgetStyleBottomContainer(
                      size: size,
                      icon: const FaIcon(FontAwesomeIcons.hotel).icon,
                      text: 'Lodging',
                      width: size.width * 0.18,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    WidgetStyleBottomContainer(
                      size: size,
                      icon: const FaIcon(FontAwesomeIcons.hotel).icon,
                      text: 'Lodging',
                      width: size.width * 0.18,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                  ],
                ),
              ),
              GridItems(),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.add),
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        // ),
      ),
    );
  }
}

class WidgetStyleContainer extends StatelessWidget {
  WidgetStyleContainer({
    super.key,
    required this.size,
    required this.icon,
    this.text = '',
    this.width = 0,
  });

  final Size size;
  final IconData icon;
  String text;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: size.width * 0.4,
      // padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.04,
            child: IconButton(
              tooltip: 'Search',
              icon: Icon(icon, size: 20),
              onPressed: () {},
            ),
          ),
          Text(text),
          SizedBox(
            width: width,
          )
        ],
      ),
    );
  }
}

class WidgetStyleBottomContainer extends StatelessWidget {
  WidgetStyleBottomContainer({
    super.key,
    required this.size,
    required this.icon,
    this.text = '',
    this.width = 0,
  });

  final Size size;
  final IconData? icon;
  String text;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.03,
      width: width,
      // padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 17,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 10),
          ),
          // SizedBox(
          //   width: width,
          // )
        ],
      ),
    );
  }
}
