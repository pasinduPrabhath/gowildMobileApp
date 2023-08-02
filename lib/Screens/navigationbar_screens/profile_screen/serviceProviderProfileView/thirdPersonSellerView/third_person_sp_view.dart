import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gowild/Screens/navigationbar_screens/profile_screen/widgets/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../backend/api_requests/client_api.dart';
import '../../widgets/profile_background.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import '../thirdPersonViewcalendar.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdPersomSpProfileScreen extends StatefulWidget {
  final String email;
  final String userName;
  const ThirdPersomSpProfileScreen(
      {required this.email, Key? key, required this.userName})
      : super(key: key);

  @override
  State<ThirdPersomSpProfileScreen> createState() =>
      _ThirdPersomSpProfileScreenState();
}

class _ThirdPersomSpProfileScreenState
    extends State<ThirdPersomSpProfileScreen> {
  late String dpUrl =
      'https://firebasestorage.googleapis.com/v0/b/gowild-4e72d.appspot.com/o/Default_Image_Thumbnail.png?alt=media&token=626ff3a4-afae-4de4-ab1e-783a2f9808c9';
  bool isLoading = true;
  bool _isLoading = false;
  bool isFollowStatLoading = true;
  bool isFollowing = false;
  bool issloading = false;
  String followerEmail = '';
  File _profilePic = File('');
  File _postPic = File('');
  List<String> _imageUrls = [];
  late int followerCount = 0;
  late int followingCount = 0;
  late int postsCount = 0;
  @override
  void initState() {
    super.initState();
    _getProfileDetails();
  }

  Future<void> _getProfileDetails() async {
    final response = await ClientAPI.getImages(widget.email);
    final profileStat = await ClientAPI.getUserDetails(widget.email);
    final prefs = await SharedPreferences.getInstance();
    followerEmail = prefs.getString('email') ?? '';
    final userProfileDetails =
        await ClientAPI.getUserProfileDetails(widget.email);
    final _dpUrl = userProfileDetails[0].dpUrl;
    _checkFollowStatus();
    final data = profileStat['data'];
    followerCount = data['followerCount'][0]['count'];
    followingCount = data['followingCount'][0]['count'];
    postsCount = data['postCount'][0]['count'];
    isFollowStatLoading = false;
    setState(() {
      _imageUrls = response;
      isLoading = false;
      dpUrl = _dpUrl;
    });
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
              isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.height * 0.03,
                      child: const CircularProgressIndicator())
                  : Text(
                      widget.userName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
              const SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThirdPersonViewCalendar(
                            email: widget.email,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(104, 55, 170, 199),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Calendar',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final phone = 0773663365;
                      launch(
                          'https://wa.me/$phone?text=Hello is this available?');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(104, 55, 170, 199),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(100, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Contact',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.message_rounded,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stat(
                          title: 'Posts',
                          value: postsCount,
                          isLoading: isFollowStatLoading),
                      Stat(
                          title: 'Followers',
                          value: followerCount,
                          isLoading: isFollowStatLoading),
                      Stat(
                          title: 'Following',
                          value: followingCount,
                          isLoading: isFollowStatLoading),
                    ]),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 1.0,
                color: const Color.fromARGB(
                    45, 3, 16, 27), // Replace with your desired color
              ),
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
              child: Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.03,
                    child: const CircularProgressIndicator()),
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
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.height * 0.03,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    Future<XFile?> file =
        ImagePicker().pickImage(imageQuality: 55, source: ImageSource.gallery);
    // XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    } //
    XFile? pickedFile = await file;
    return File(pickedFile!.path);
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
        referenceRoot.child('$imageCategory/$widget.email/$uniqueFileName');
    try {
      await fileReference.putFile(imageFile);
      final imageUrl = await fileReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      throw Exception('Failed to upload image');
    }
  }

  Future<String> uploadPostImage(
    File imageFile,
    String suffix,
    String imageCategory,
  ) async {
    // Check if image file is null
    if (imageFile == null) {
      throw Exception('No image selected');
    }

    String uniqueFileName =
        suffix + DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();

    Reference fileReference =
        referenceRoot.child('$imageCategory/$widget.email/$uniqueFileName');
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
