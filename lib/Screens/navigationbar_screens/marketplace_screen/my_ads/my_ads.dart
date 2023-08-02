import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/my_ads/widgets/my_grid_items.dart';
import '../equipment_ads/marketPlace_newAd.dart';
import '../marketplaceBackground.dart';
import '../marketplace_screen.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';

import '../photo_ads/photo_selling_ads.dart';
import '../tour_plan_ads/add_tour_ads.dart';

class MyAds extends StatefulWidget {
  final accountType;
  const MyAds({Key? key, this.accountType}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomFloatingActionButton(
      backgroundColor: const Color.fromARGB(199, 26, 25, 25),
      floatinButtonColor: const Color.fromARGB(255, 169, 217, 245),
      body: MarketplaceBackground(
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
                print('account typess: ${widget.accountType}');
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
        ),
      ),
      options: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNewAd()),
            );
          },
          child: const CircleAvatar(
            child: FaIcon(FontAwesomeIcons.plus),
          ),
        ),
        // Add more options here as needed
        if (widget.accountType == 'serviceProvider')
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTourAds()),
              );
            },
            child: const CircleAvatar(
              child: FaIcon(FontAwesomeIcons.vanShuttle),
            ),
          ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddPhotoSellingAd()),
            );
          },
          child: CircleAvatar(
            child: FaIcon(FontAwesomeIcons.camera),
          ),
        ),
      ],
      type: CustomFloatingActionButtonType.circular,
      openFloatingActionButton: const Icon(Icons.add),
      closeFloatingActionButton: const Icon(Icons.close),
    );
  }
}
