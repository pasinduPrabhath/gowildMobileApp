import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/home_screen/widgets/background.dart';
import 'package:http/http.dart' as http;

import '../../../reusable_components/customizedAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> fetchUserPicsForFeed() async {
    // final response = await http.post(Uri.parse(
    //     'http://127.0.0.1:3000/api/user/getAllUserPicsForFeed'));
    final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/api/user/getAllUserPicsForFeed'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomizedAppBar(
            key: UniqueKey(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<List<dynamic>>(
                future: fetchUserPicsForFeed(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data?.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final user = data?[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 32.0,
                          ),
                          padding: const EdgeInsets.all(14.0),
                          height: size.height * 0.4,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage(user?['url']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16.0,
                                      backgroundImage: NetworkImage(
                                          user?['profile_picture_url']),
                                    ),
                                    SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${user?['firstName']} ${user?['lastName']}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Container _buildPostStat({
  //   required BuildContext context,
  //   required String likeCount,
  //   required Icon icon,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Color.fromARGB(150, 190, 184, 184),
  //       borderRadius: BorderRadius.circular(35.0),
  //     ),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           onPressed: () {},
  //           icon: icon,
  //         ),
  //         Text(
  //           likeCount,
  //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                 color: Colors.white,
  //               ),
  //         ),
  //         const SizedBox(width: 15.0),
  //       ],
  //     ),
  //   );
  // }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color.fromARGB(139, 231, 230, 230),
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            // Clear the search text
          },
        ),
      ),
      onChanged: (value) {
        // Update the search text
      },
    );
  }
}
