import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../equipment_ads/marketProductDescription.dart';
import 'package:intl/intl.dart';

import '../photo_ads/third_person_view/photo_third_person_view.dart';

class GridItems extends StatefulWidget {
  final Future<List<dynamic>> Function() apiFunction;
  const GridItems({
    super.key,
    required this.apiFunction,
  });

  @override
  State<GridItems> createState() => _GridItemsState();
}

class _GridItemsState extends State<GridItems> {
  final adIcons = const [
    FontAwesomeIcons.circleCheck,
    FontAwesomeIcons.car,
    FontAwesomeIcons.houseUser,
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.cameraRetro,
    FontAwesomeIcons.photoFilm,
    FontAwesomeIcons.hotel
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: widget.apiFunction(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final ads = snapshot.data;

          return GridView.builder(
            itemCount: ads!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final ad = ads[index];
              final adType = ad['adType'];
              IconData adIcon = Icons.location_city;
              if (adType == 'Photos') {
                adIcon = adIcons[adIcons.indexOf(FontAwesomeIcons.photoFilm)];
              }
              if (adType == 'Equipment') {
                adIcon = adIcons[adIcons.indexOf(FontAwesomeIcons.utensils)];
              }
              if (adType == 'Safari') {
                adIcon = adIcons[adIcons.indexOf(FontAwesomeIcons.car)];
              }
              if (adType == 'Rent') {
                adIcon = adIcons[adIcons.indexOf(FontAwesomeIcons.houseUser)];
              }
              if (adType == 'Lodging') {
                adIcon = adIcons[adIcons.indexOf(FontAwesomeIcons.hotel)];
              }
              if (adType == 'Food') {
                adIcon = adIcons[adIcons.indexOf(FontAwesomeIcons.utensils)];
              }

              //  adIcon = adIcons[adIconIndex];

              return Container(
                height: MediaQuery.of(context).size.height * 0.15,
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(136, 147, 211, 241),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Display the related icon based on adType
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, bottom: 2),
                                child: Icon(
                                  adIcon,
                                  size: 12,
                                ),
                              ),
                              Text(
                                '${ad['district']}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 12, 12, 12),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            // print(ad['user_id']);
                            if (adType == 'Photos') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoAdDescription(ad: ad),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDescription(ad: ad),
                                ),
                              );
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ad['imageLinks'].isEmpty
                                ? Container() // Show empty container if imageLinks is empty
                                : Image.network(
                                    ad['imageLinks'][0],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ad['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 12, 12, 12),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  adType == 'Photos'
                                      ? 'Tap for prices'
                                      : 'Rs. ${NumberFormat('#,##0').format(ad['price'])}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 68, 67, 67),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
