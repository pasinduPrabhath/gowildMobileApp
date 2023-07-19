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
import '../calendar.dart';

class ServiceProviderProfileScreen extends StatefulWidget {
  const ServiceProviderProfileScreen({super.key});

  @override
  State<ServiceProviderProfileScreen> createState() =>
      _ServiceProviderProfileScreenState();
}

class _ServiceProviderProfileScreenState
    extends State<ServiceProviderProfileScreen> {
  late String? userName;
  late String? email;
  late String dpUrl =
      'https://firebasestorage.googleapis.com/v0/b/gowild-4e72d.appspot.com/o/Default_Image_Thumbnail.png?alt=media&token=626ff3a4-afae-4de4-ab1e-783a2f9808c9';
  bool isLoading = true;
  bool isFollowStatLoading = true;
  bool issloading = false;
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
    // Retrieve the email from SharedPreferences
    var response;
    // print(response[0]);

    // isLoading = false;
    // setState(() {

    //   isLoading = false;
    // });
    if (!mounted) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      userName = prefs.getString('displayName') ?? '';
      email = prefs.getString('email') ?? '';
      dpUrl = prefs.getString('dpUrl') ?? '';
      print('dpurl' + dpUrl);
      response = await ClientAPI.getImages(email!);
      final profileStat = await ClientAPI.getUserDetails(email!);
      final data = profileStat['data'];
      followerCount = data['followerCount'][0]['count'];
      followingCount = data['followingCount'][0]['count'];
      postsCount = data['postCount'][0]['count'];
      isFollowStatLoading = false;
    } catch (e) {
      print('Error getting profile details: $e');
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _imageUrls = response;
      isLoading = false;
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/');
                                    },
                                    child: const Text('Logout',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23.0),
                      child: IconButton(
                        onPressed: () async {
                          final image = await pickImage();
                          setState(() {
                            _postPic = image!;
                          });
                          issloading = true;
                          final imageUrl = await uploadPostImage(
                              _postPic, 'post', 'postPic');
                          final result = await ClientAPI.updateUserPostPicture(
                              email!, imageUrl);
                          print(result);
                          issloading = false;
                          setState(() {
                            _getProfileDetails();
                          });
                        },
                        icon: const Icon(Icons.add_a_photo_sharp),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        elevation: 2,
                        backgroundColor: const Color.fromARGB(155, 10, 10, 10),
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: size.height * 0.13,
                            child: Center(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final previousImageUrl = dpUrl;
                                    final image = await pickImage();
                                    if (image == null) {
                                      return;
                                    }
                                    setState(() {
                                      _profilePic = image;
                                      issloading = true;
                                    });
                                    final imageUrl = await uploadProfileImage(
                                        _profilePic,
                                        'profilePic',
                                        'profilePic',
                                        previousImageUrl);
                                    setState(() {
                                      dpUrl = imageUrl;
                                    });
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString('dpUrl', dpUrl);
                                    await ClientAPI.updateUserProfilePicture(
                                        email!, dpUrl);
                                    setState(() {
                                      issloading = false;
                                    });

                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Open Gallery',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                          );
                        },
                      );
                    },
                    child: Align(
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
                                    color:
                                        const Color.fromARGB(255, 19, 18, 18)),
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
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                // Show a placeholder image or an error message
                                return Image.asset(
                                    'assets/images/placeholder.png');
                              },
                            ),
                          )
                        ],
                      ),
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
                      '$userName',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
              const SizedBox(
                height: 6.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomCalender(),
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
                    height: MediaQuery.of(context).size.height * 0.03,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PhotoPreviewScreen(imageUrl: url, tag: 'photo_$index'),
            ),
          );
        },
        onLongPress: () {
          showModalBottomSheet(
            elevation: 2,
            backgroundColor: const Color.fromARGB(155, 10, 10, 10),
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.of(context).pop(); // Close the bottom sheet
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Deletion'),
                            content: const Text(
                                'Are you sure you want to delete this photo?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          issloading = true;
                          await FirebaseStorage.instance
                              .refFromURL(url)
                              .delete();
                          print('url is' + url);
                          print('email is' + email!);
                          await ClientAPI.deletePost(email!, url);
                          issloading = false;
                          setState(() {
                            _getProfileDetails();
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Delete photo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
              );
            },
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
        ImagePicker().pickImage(imageQuality: 15, source: ImageSource.gallery);
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
        referenceRoot.child('$imageCategory/$email/$uniqueFileName');
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
        referenceRoot.child('$imageCategory/$email/$uniqueFileName');
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
