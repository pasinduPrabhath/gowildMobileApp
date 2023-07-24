import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/tour_plan_ads/add_tour_ads.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/widgets/grid_items.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gowild/backend/api_requests/client_api.dart';
import 'equipment_ads/marketPlace_newAd.dart';
import 'marketplaceBackground.dart';
import 'my_ads/my_ads.dart';
import 'package:custom_floating_action_button/custom_floating_action_button.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    GridItems(
      apiFunction: () => ClientAPI.getAds(),
    );
    super.initState();
  }

  Future<void> getPage() async {
    setState(() {});
    GridItems(
      apiFunction: () => ClientAPI.getAds(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MarketplaceBackground(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is OverscrollNotification) {
            setState(() {});
          }
          return false;
        },
        child: CustomFloatingActionButton(
          backgroundColor: const Color.fromARGB(199, 26, 25, 25),
          floatinButtonColor: const Color.fromARGB(255, 169, 217, 245),
          body: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                await getPage();
                setState(() {});
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Marketplace',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 14, 14, 14))),
                          Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: WidgetStyleContainer(
                              size: size,
                              icon: Icons.search,
                              text: 'Search',
                              width: size.width * 0.07,
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: WidgetStyleContainer(
                                size: size,
                                icon: FontAwesomeIcons.user,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyAds())).then((value) {
                                    if (value == true) {
                                      Navigator.popUntil(context,
                                          ModalRoute.withName('/marketplace'));
                                    }
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
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
                            // text: 'Safari',
                            dropdownValue: 'Tour Items',
                            width: size.width * 0.3,
                            items: const [
                              'Tour Items',
                              'Safari',
                              'Rent',
                              'Food'
                            ],
                            icons: const [
                              FontAwesomeIcons.car,
                              FontAwesomeIcons.car,
                              FontAwesomeIcons.houseUser,
                              FontAwesomeIcons.utensils
                            ],
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          WidgetStyleBottomContainer(
                            size: size,
                            icon: const FaIcon(FontAwesomeIcons.camera).icon,
                            // text: 'Camera',
                            width: size.width * 0.3,
                            items: [],
                            icons: [],
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          WidgetStyleBottomContainer(
                            size: size,
                            icon: const FaIcon(FontAwesomeIcons.photoFilm).icon,
                            // text: 'Photos',
                            width: size.width * 0.3,
                            items: [],
                            icons: [],
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                        ],
                      ),
                    ),
                    const GridItems(apiFunction: ClientAPI.getAds),
                  ],
                ),
              ),
            ),
          ),
          options: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNewAd()));
              },
              child: const CircleAvatar(
                child: Icon(Icons.sell),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTourAds()));
              },
              child: const CircleAvatar(
                child: FaIcon(FontAwesomeIcons.vanShuttle),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNewAd()));
              },
              child: const CircleAvatar(
                child: FaIcon(FontAwesomeIcons.vanShuttle),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNewAd()));
              },
              child: const CircleAvatar(
                child: FaIcon(FontAwesomeIcons.vanShuttle),
              ),
            ),
          ],
          type: CustomFloatingActionButtonType.values[0],
          openFloatingActionButton: const Icon(Icons.add),
          closeFloatingActionButton: const Icon(Icons.close),
        ),
      ),
    );
  }
}

class WidgetStyleContainer extends StatelessWidget {
  const WidgetStyleContainer({
    Key? key,
    required this.size,
    required this.icon,
    this.text = '',
    this.width = 0,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  final Size size;
  final IconData icon;
  final String text;
  final double width;

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
              onPressed: onPressed,
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

class WidgetStyleBottomContainer extends StatefulWidget {
  WidgetStyleBottomContainer({
    Key? key,
    required this.size,
    required this.icon,
    // this.text = '',
    this.width = 0,
    required this.items,
    required this.icons,
    this.dropdownValue,
  }) : super(key: key);

  final Size size;
  final IconData? icon;
  // final String text;
  final double width;
  late String? dropdownValue;
  final List<String> items;
  final List<IconData> icons;

  @override
  State<WidgetStyleBottomContainer> createState() =>
      _WidgetStyleBottomContainerState();
}

class _WidgetStyleBottomContainerState
    extends State<WidgetStyleBottomContainer> {
  //  dropdownValue = 'Traveling';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.04,
      width: widget.width,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: widget.dropdownValue,
            icon:
                const Icon(Icons.arrow_drop_down), // Icon before dropdown value
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 0,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.dropdownValue = newValue!;
              });
              //switch case here.
            },
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10), // Rounded border
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              IconData icon;
              if (value == widget.items[0]) {
                icon = widget.icons[0];
              } else if (value == widget.items[1]) {
                icon = widget.icons[1];
              } else if (value == widget.items[2]) {
                icon = widget.icons[2];
              } else {
                icon = widget.icons[3];
              }
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 16,
                      ), // Icon before dropdown value
                      const SizedBox(
                          width: 8), // Add some space between icon and text
                      Text(
                        value,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
  //add custom floating action button on top of your scaffold
//minimum 2 and maximum 5 items allowed
}

@override
Widget build(BuildContext context) {
  return CustomFloatingActionButton(
    body: Scaffold(
      appBar: AppBar(
        title: const Text('appbar title'),
      ),
      body: Container(),
    ),
    options: const [
      CircleAvatar(
        child: Icon(Icons.height),
      ),
      CircleAvatar(
        child: Icon(Icons.title),
      ),
    ],
    type: CustomFloatingActionButtonType.circular,
    openFloatingActionButton: const Icon(Icons.add),
    closeFloatingActionButton: const Icon(Icons.close),
  );
}
