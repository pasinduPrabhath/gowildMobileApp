import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/widgets/product_images_slider.dart';
import 'package:gowild/backend/api_requests/client_api.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../../profile_screen/clientProfileView/thirdPersonView/thirdPersonProfileView.dart';

class PhotoAdDescription extends StatefulWidget {
  final Map<String, dynamic>? ad;

  const PhotoAdDescription({Key? key, required this.ad}) : super(key: key);

  @override
  State<PhotoAdDescription> createState() => _PhotoAdDescriptionState();
}

class _PhotoAdDescriptionState extends State<PhotoAdDescription> {
  List<dynamic> userDetails = [];
  bool isLoading = true;
  String formattedTime = '';
  String name = '';
  String email = '';
  // final timestamp = DateTime.parse('2022-01-01 12:00:00');

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  void getDetails() async {
    // print(widget.ad?['phone_num']);
    userDetails =
        await ClientAPI.getSimpleUserDetails(widget.ad?['user_id'] ?? '');
    setState(() {
      isLoading = false;
      name = userDetails[0]['firstName'] + ' ' + userDetails[0]['lastName'];
      email = userDetails[0]['email'];
    });
    if (userDetails.isNotEmpty) {
      final timestamp = widget.ad?['timestamp'];
      if (timestamp != null) {
        formattedTime = timeago.format(DateTime.parse(timestamp));
        print(formattedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ad == null) {
      return const Scaffold(
        body: Center(
          child: Text('Ad not found'),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(137, 205, 225, 240),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: ProductImagesSlider(
                        imageUrls: (widget.ad?['imageLinks'] as List<dynamic>)
                            .cast<String>(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ad?['title'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Posted $formattedTime',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.ad?['location'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 223, 223, 223),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ThirdPersonProfileScreen(
                                      email: email,
                                      userName: name,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: userDetails.isNotEmpty
                                          ? NetworkImage(userDetails[0]
                                              ['profile_picture_url'])
                                          : null,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: const Color.fromARGB(255, 223, 223, 223),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.ad?['description'] ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                String? phoneNumber = widget.ad?['phone_num'].toString();
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: phoneNumber,
                );
                await launchUrl(launchUri);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.height / 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 70, 164, 241),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Call',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final phone = widget.ad?['phone_num'];
                launch('https://wa.me/$phone?text=Hello is this available?');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.height / 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 70, 164, 241),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
