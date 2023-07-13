import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gowild/Screens/navigationbar_screens/profile_screen/widgets/stat.dart';
import 'package:gowild/Screens/screen_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../backend/api_requests/client_api.dart';
import '.././widgets/profile_background.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';

import '../profile_screen.dart';

class ThirdPersonProfileScreen extends StatefulWidget {
  final String email;
  final String userName;
  const ThirdPersonProfileScreen(
      {required this.email, Key? key, required this.userName})
      : super(key: key);

  @override
  State<ThirdPersonProfileScreen> createState() =>
      _ThirdPersonProfileScreenState();
}

// Add email parameter to the constructor

// const ThirdPersonProfileScreen({required this.email, Key? key})
//     : super(key: key);

class _ThirdPersonProfileScreenState extends State<ThirdPersonProfileScreen> {
  // late String? userName;
  // late String? email;
  bool isFollowing = false;
  late String dpUrl =
      'https://firebasestorage.googleapis.com/v0/b/gowild-4e72d.appspot.com/o/Default_Image_Thumbnail.png?alt=media&token=626ff3a4-afae-4de4-ab1e-783a2f9808c9';
  bool isLoading = true;
  bool issloading = false;
  File _profilePic = File('');
  File _postPic = File('');
  String followerEmail = '';
  List<String> _imageUrls = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getDetails();
    _getProfileDetails();
    // _checkFollowStatus();
  }

  void getDetails() async {
    print('getting details');
    final userProfileDetails =
        await ClientAPI.getUserProfileDetails(widget.email);
    final _dpUrl = userProfileDetails[0].dpUrl;
    final _followingId = userProfileDetails[0].userId;
    print('following id $_followingId');
    setState(() {
      dpUrl = _dpUrl;
    });
    print('dpUrl $dpUrl');
    final prefs = await SharedPreferences.getInstance();
    followerEmail = prefs.getString('email') ?? '';
    print('follower email $followerEmail');
    final response =
        await ClientAPI.getFollowerStatus(followerEmail, widget.email);
    print('response $response');
    setState(() {
      isFollowing = response;
    });
  }

  Future<void> _getProfileDetails() async {
    if (_imageUrls.isEmpty) {
      final response = await ClientAPI.getImages(widget.email);
      print(response[0]);

      setState(() {
        _imageUrls = response;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _checkFollowStatus() async {
    setState(() {
      isFollowing = !isFollowing;
    });
    final response =
        await ClientAPI.getFollowerStatus(followerEmail, widget.email);
    print('response $response');
    setState(() {
      isFollowing = response;
    });
  }

  Future<void> _toggleFollowStatus() async {
    setState(() {
      _isLoading = true;
    });
    if (isFollowing) {
      await ClientAPI.unfollowUser(followerEmail, widget.email);
      // isFollowing = false;
    } else {
      await ClientAPI.followUser(followerEmail, widget.email);
    }
    setState(() {
      isFollowing = !isFollowing;
      _isLoading = false;
    });
  }

  late final XFile _image = XFile('assets/images/default_profile_pic.png');
  String _selectedTab = 'photos';
  _changeTab(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ProfileBackground(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 23.0),
                      child: IconButton(
                        onPressed: _toggleFollowStatus,
                        icon: Icon(
                          isFollowing
                              ? Icons.person_remove_alt_1
                              : Icons.person_add_alt_1,
                          color: isFollowing
                              ? const Color.fromARGB(255, 7, 7, 7)
                              : null,
                        ),
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 38.0, top: 15.0),
                        child: Container(
                          width: size.width * 0.04,
                          height: size.width * 0.04,
                          color: Colors.transparent,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 14, 131, 131),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.rotate(
                          // alignment: Alignment.center,
                          angle: math.pi / 4,
                          child: Container(
                            width: 140.0,
                            height: 140.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 0, 0, 0),
                              border: Border.all(
                                  width: 1.0,
                                  color: const Color.fromARGB(255, 19, 18, 18)),
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: ProfilePicCliper(),
                          child: Image.network(
                            dpUrl,
                            width: 180.0,
                            height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //image and border of dp
              // IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      '${widget.userName}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '@pasindu_prabhath',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stat(title: 'Posts', value: 45),
                      Stat(title: 'Followers', value: 1552),
                      Stat(title: 'Following', value: 128),
                    ]),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenController()));
                  },
                  child: Icon(
                    Icons.photo_outlined,
                    size: 35,
                    color: _selectedTab == 'photos'
                        ? const Color.fromARGB(255, 54, 164, 168)
                        : null,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // final res = await ClientAPI.getFollowerStatus(
                    //     followerEmail, widget.email);
                    // print('res $res');
                  },
                  child: Icon(
                    Icons.bookmark_outline_outlined,
                    size: 35,
                    color: _selectedTab == 'saved'
                        ? const Color.fromARGB(255, 54, 164, 168)
                        : null,
                  ),
                ),
              ]),
              // staggered grid view
              Expanded(
                child: GridView.custom(
                  padding:
                      const EdgeInsets.only(bottom: 46, left: 16, right: 16),
                  gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    repeatPattern: QuiltedGridRepeatPattern.inverted,
                    pattern: const [
                      QuiltedGridTile(4, 4),
                      QuiltedGridTile(2, 2),
                      QuiltedGridTile(2, 2),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return pictureTile(1, _imageUrls[index], index);
                    },
                    childCount: _imageUrls.length,
                  ),
                ),
              ),
            ],
          ),
          if (issloading)
            Container(
              color: Colors.black
                  .withOpacity(0.85), // Set the color to transparent black
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget pictureTile(double cellcount, String url, int index) {
    return Hero(
      tag: 'photo_$index', // Provide a unique tag for each photo
      child: GestureDetector(
        onTap: () {
          // Handle the tap event and navigate to the preview screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PhotoPreviewScreen(imageUrl: url, tag: 'photo_$index'),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    } //
    return File(file.path);
  }

  Future<String> uploadProfileImage(
    File imageFile,
    String suffix,
    String imageCategory,
    String previousImageUrl,
  ) async {
    // Check if image file is null
    if (imageFile == null) {
      throw Exception('No image selected');
    }

    String uniqueFileName =
        suffix + DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();

    if (previousImageUrl != null && previousImageUrl.isNotEmpty) {
      try {
        Reference previousImageReference =
            FirebaseStorage.instance.refFromURL(previousImageUrl);
        await previousImageReference.delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }

    Reference fileReference =
        referenceRoot.child('$imageCategory/${widget.email}/$uniqueFileName');
    try {
      await fileReference.putFile(imageFile);
      final imageUrl = await fileReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      throw Exception('Failed to upload image');
    }
  }
}

class ProfilePicCliper extends CustomClipper<Path> {
  double radius = 35.0;

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width / 2 - radius, radius)
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + radius, radius)
      ..lineTo(size.width - radius, size.height / 2 - radius)
      ..quadraticBezierTo(size.width, size.height / 2, size.width - radius,
          size.height / 2 + radius)
      ..lineTo(size.width / 2 + radius, size.height - radius)
      ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 - radius,
          size.height - radius)
      ..lineTo(radius, size.height / 2 + radius)
      ..quadraticBezierTo(0, size.height / 2, radius, size.height / 2 - radius)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class PhotoPreviewScreen extends StatelessWidget {
  final String imageUrl;
  final String tag;
  const PhotoPreviewScreen(
      {super.key, required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the tap event to close the preview screen
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle the tap event to close the preview screen
                  Navigator.pop(context);
                },
                child: Center(
                  child: Hero(
                    tag: tag, // Use the same tag as the photo in the grid
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       showDialog(
  //         context: context,
  //         builder: (_) => Dialog(
  //           child: Image.network(widget.imageUrl),
  //         ),
  //       );
  //     },
  //     child: FutureBuilder(
  //       future: _imageFuture,
  //       builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           return Container(
  //             width: 100,
  //             height: 100,
  //             margin: const EdgeInsets.only(right: 8),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(8),
  //               image: DecorationImage(
  //                 image: NetworkImage(widget.imageUrl),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         } else if (response == 404) {
  //           return widget.errorBuilder(
  //             context,
  //             Exception('Failed to load image'),
  //             null,
  //           );
  //         } else {
  //           return const SizedBox(
  //             width: 100,
  //             height: 100,
  //             child: Center(child: CircularProgressIndicator()),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
