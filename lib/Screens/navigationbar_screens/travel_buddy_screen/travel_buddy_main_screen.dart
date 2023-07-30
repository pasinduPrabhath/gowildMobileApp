import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/widgets/requestShowCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MySpace/createNewTravelBuddyInvite.dart';
import 'MySpace/mySpace.dart';

// import '../marketplace_screen/marketplace_screen.dart';

class TravelBuddyMainScreen extends StatefulWidget {
  const TravelBuddyMainScreen({super.key});

  @override
  State<TravelBuddyMainScreen> createState() => _TravelBuddyMainScreenState();
}

class _TravelBuddyMainScreenState extends State<TravelBuddyMainScreen> {
  String userEmail = '';
  @override
  void initState() {
    //get email from shared preferences
    _getDetails();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _getDetails() async {
    print('getting details...');
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('email') ?? '';
    print(userEmail);
  }

  String selectedCategory = 'All Locations';

  void onCategoryChanged(String? newCategory) {
    setState(() {
      selectedCategory = newCategory!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var selectedCategory = 'All ads';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('Travel Buddy'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.my_library_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MySpaceScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
                  child: WidgetStyleBottomContainer(
                    size: size,
                    icon: const FaIcon(FontAwesomeIcons.car).icon,
                    // text: 'Safari',
                    dropdownValue: selectedCategory,
                    width: size.width * 0.36,
                    items: const [
                      'All Locations',
                      'Ampara',
                      'Anuradhapura',
                      'Badulla',
                      'Batticaloa',
                      'Colombo',
                      'Galle',
                      'Gampaha',
                      'Hambantota',
                      'Jaffna',
                      'Kalutara',
                      'Kandy',
                      'Kegalle',
                      'Kilinochchi',
                      'Kurunegala',
                      'Mannar',
                      'Matale',
                      'Matara',
                      'Monaragala',
                      'Mullaitivu',
                      'Nuwara Eliya',
                      'Polonnaruwa',
                      'Puttalam',
                      'Ratnapura',
                      'Trincomalee',
                      'Vavuniya',
                    ],
                    icons: const [
                      FontAwesomeIcons.circleCheck,
                      FontAwesomeIcons.locationDot,
                    ],
                    selectedCategory: selectedCategory,
                    onCategoryChanged: onCategoryChanged,
                  ),
                ),
              ],
            ),
            RequestCardView(
              size: size,
            ),
            SizedBox(height: size.height * 0.1)
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNewTravelBuddyInvite(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
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
    required this.selectedCategory,
    required this.onCategoryChanged,
  }) : super(key: key);

  final Size size;
  final IconData? icon;
  final void Function(String?) onCategoryChanged;
  final double width;
  late String? dropdownValue;
  final List<String> items;
  final List<IconData> icons;
  late String? selectedCategory;

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton<String>(
            menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
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
                widget.selectedCategory = newValue;
              });
              widget.onCategoryChanged(newValue);
              //switch case here.
            },
            itemHeight: 50,
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10), // Rounded border
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              IconData icon;
              if (value == widget.items[0]) {
                icon = widget.icons[0];
              } else {
                icon = widget.icons[1];
              }
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 16,
                        ), // Icon before dropdown value
                        const SizedBox(
                            width: 10), // Add some space between icon and text
                        Text(
                          value,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
