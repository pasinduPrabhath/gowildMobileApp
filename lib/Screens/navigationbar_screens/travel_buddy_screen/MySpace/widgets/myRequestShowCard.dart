import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/widgets/requestModel.dart';
import 'package:gowild/backend/api_requests/client_api.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../profile_screen/clientProfileView/thirdPersonView/thirdPersonProfileView.dart';

class MyRequestShowCard extends StatefulWidget {
  MyRequestShowCard({
    Key? key,
    required this.size,
    // email,
  }) : super(key: key);

  final Size size;
  String email = '';

  @override
  State<MyRequestShowCard> createState() => _MyRequestShowCardState();
}

class _MyRequestShowCardState extends State<MyRequestShowCard> {
  bool isloading = false;
  Future<void> _getDetails() async {
    final prefs = await SharedPreferences.getInstance();
    widget.email = prefs.getString('email') ?? '';
    print('email is ${widget.email}');
  }

  // bool isInterested = false;

  void toggleInterested(int postId, int likeStatus) {
    setState(() {
      if (likeStatus == 1) {
        likeStatus = 0;
      } else {
        likeStatus = 1;
      }
    });
    isloading = true;
    // Update the interested button color immediately
    final interestresult = likeStatus == 1
        ? ClientAPI.addInterestToTB(widget.email, postId)
        : ClientAPI.removeInterestToTB(widget.email, postId);

    interestresult.then((value) {
      print('interest result: $value');

      setState(() {});
      isloading = false;
    }).catchError((error) {
      print('API error: $error');
      setState(() {});
    });
  }

  @override
  void initState() {
    _getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: widget.size.height * 0.8,
        child: FutureBuilder<List<Request>>(
          future: ClientAPI.getTravelBuddyReqById(widget.email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final requests = snapshot.data!;
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  final placeName =
                      '${request.place[0].toUpperCase()}${request.place.substring(1)}';

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: GestureDetector(
                                    onTap: () async {
                                      //create a popup window to confirm delete
                                      await
                                          // ignore: deprecated_member_use
                                          showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Delete Request',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to delete this request?',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await ClientAPI
                                                      .deleteTravelBuddyReq(
                                                          request.postId);
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(Icons.delete)),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ThirdPersonProfileScreen(
                                        email: request.email,
                                        userName:
                                            '${request.firstName} ${request.lastName}',
                                      ),
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage(request.profilePictureUrl),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ThirdPersonProfileScreen(
                                                email: request.email,
                                                userName:
                                                    '${request.firstName} ${request.lastName}',
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            '${request.firstName} ',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          'is traveling to ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          placeName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // Stack(

                                        //   children: [
                                        //     IconButton(
                                        //       onPressed: () {},
                                        //       icon: const Icon(Icons.delete),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${timeago.format(DateTime.parse(request.timestamp))}, ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Traveling on ${DateFormat('dd MMMM yyyy').format(DateTime.parse(request.date.toString()))}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        // Text(
                                        //   'bool ${request.isLiked.toString()}',
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 20),
                            child: Text(
                              request.content,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print('email: ${widget.email}');
                                    setState(() {
                                      toggleInterested(
                                          request.postId, request.isLiked);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        request.isLiked == 1
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: request.isLiked == 1
                                            ? Colors.red
                                            : null,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Interested',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(Icons.person_outline),
                                    const SizedBox(width: 5),
                                    Row(
                                      children: [
                                        const Text(
                                          '2/',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${request.noOfParticipants}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'People',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    // SizedBox(width: size.width * 0.1),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ThirdPersonProfileScreen(
                                        email: request.email,
                                        userName:
                                            '${request.firstName} ${request.lastName}',
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.message_outlined),
                                      SizedBox(width: 5),
                                      Text(
                                        'Contact',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Failed to fetch requests',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      if (isloading)
        const Center(
          child: CircularProgressIndicator(),
        )
    ]);
  }
}
