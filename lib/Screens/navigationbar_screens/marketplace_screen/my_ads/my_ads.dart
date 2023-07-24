import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/my_ads/widgets/my_grid_items.dart';
import '../equipment_ads/marketPlace_newAd.dart';
import '../marketplaceBackground.dart';
import '../marketplace_screen.dart';

class MyAds extends StatefulWidget {
  const MyAds({super.key});

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MarketplaceBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'My Ads',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 14, 14, 14),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              const MyGridItems(),
            ],
          ),
        ),
        floatingActionButton: Stack(children: [
          Positioned(
            bottom: 45.0,
            right: 0.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNewAd()));
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
