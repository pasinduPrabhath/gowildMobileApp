import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/widgets/grid_items.dart';

import '../../../reusable_components/customizedAppBar.dart';
import 'marketplaceBackground.dart';

class MarketPlaceScreen extends StatelessWidget {
  const MarketPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MarketplaceBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.13,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          tooltip: 'Search',
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        // const Text('Search'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GridItems(),
          ],
        ),
      ),
    );
  }
}
