import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gowild/Screens/navigationbar_screens/profile_screen/widgets/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../backend/api_requests/client_api.dart';
import './widgets/profile_background.dart';
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String? userName;
  late String? email;
  late String dpUrl =
      'https://www.pngitem.com/pimgs/m/551-5510463_default-user-image-png-transparent-png.png';
  bool isLoading = true;
  File _profilePic = File('');
  @override
  void initState() {
    super.initState();
    _getProfileDetails();
  }

  Future<void> _getProfileDetails() async {
    // Retrieve the email from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('displayName') ?? '';
    email = prefs.getString('email') ?? '';
    dpUrl = prefs.getString('dpUrl') ?? '';
    // isLoading = false;
    setState(() {
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

  Future<void> _getImageFromGallery(XFile image) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = XFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   _image = XFile('assets/images/default_profile_pic.png');
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ProfileBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
                        _getImageFromGallery(_image);
                        // Navigator.pop(context);
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
                                  });
                                  final imageUrl = await uploadImage(
                                      _profilePic,
                                      'profilePic',
                                      'profilePic',
                                      previousImageUrl);
                                  setState(() {
                                    dpUrl = imageUrl;
                                  });
                                  // final prefs =
                                  //     await SharedPreferences.getInstance();
                                  // await prefs.setString('dpUrl', dpUrl);
                                  print(dpUrl);
                                  final emailid =
                                      await ClientAPI.updateUserProfilePicture(
                                          email!, dpUrl);

                                  Navigator.pop(context);
                                  print(emailid);
                                  print(email);
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
                ),
              ],
            ),
            //image and border of dp
            // IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            isLoading
                ? const CircularProgressIndicator()
                : Text(
                    '$userName',
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
              height: 80.0,
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
              height: 50.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              GestureDetector(
                onTap: () => _changeTab('photos'),
                child: Icon(
                  Icons.photo_outlined,
                  size: 35,
                  color: _selectedTab == 'photos'
                      ? const Color.fromARGB(255, 54, 164, 168)
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () => _changeTab('saved'),
                child: Icon(
                  Icons.bookmark_outline_outlined,
                  size: 35,
                  color: _selectedTab == 'saved'
                      ? const Color.fromARGB(255, 54, 164, 168)
                      : null,
                ),
              ),
            ]),
            //staggered grid view
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14.0,
                  crossAxisSpacing: 14.0,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.network(
                            'https://scontent.fcmb11-1.fna.fbcdn.net/v/t39.30808-6/357407685_9473251802748864_8618071103049731290_n.jpg?stp=dst-jpg_p526x395&_nc_cat=106&cb=99be929b-3346023f&ccb=1-7&_nc_sid=0debeb&_nc_eui2=AeFwI_MkspQi-CnUjEGKuuj8OYYsxfx1PdQ5hizF_HU91HtJFxkFdMJXj9-KG_rxlf8SY453mXxXc4ysGZd6oRyg&_nc_ohc=FKjX7WIwfoIAX9EQbPd&_nc_oc=AQnuhOljt63k_bnqKM3dmcAVAbH0WdWbB7QiQ-IbIYy7a4qMhFoB8NF55tLfg0AmJzQ&_nc_zt=23&_nc_ht=scontent.fcmb11-1.fna&oh=00_AfDFc906MS3dWMWl2LzasI_xfcPFytuytD_M81taWBB1yw&oe=64AAFE33',
                            fit: BoxFit.cover),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.network(
                            'https://scontent.fcmb11-1.fna.fbcdn.net/v/t39.30808-6/357716591_9473251459415565_5642185421229424597_n.jpg?_nc_cat=104&cb=99be929b-3346023f&ccb=1-7&_nc_sid=0debeb&_nc_eui2=AeH213Am_1JDu0xMWxHoHjOBtDVJdwVh73W0NUl3BWHvdfQ3qIvLbn0hPZSpd70rZTARBqfaLmls9Xi7J3AoqFed&_nc_ohc=VQvkguDybO0AX8DiOeU&_nc_zt=23&_nc_ht=scontent.fcmb11-1.fna&oh=00_AfAdmreZsH6_eSOC_93fs0VgHroUmls-PgQhA2OxtzwnDw&oe=64AB63D2',
                            fit: BoxFit.cover),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.network(
                            'https://scontent.fcmb11-1.fna.fbcdn.net/v/t39.30808-6/356997943_9468372843236760_8557570635083891094_n.jpg?stp=dst-jpg_p180x540&_nc_cat=107&cb=99be929b-3346023f&ccb=1-7&_nc_sid=0debeb&_nc_eui2=AeEUDIxsEitEmNd3c_23VzCOnBNYcD3HD0icE1hwPccPSATcOPM04RswdYC_7R_1BtJAOXcoM7ITHkQEKdYRdXez&_nc_ohc=eA_BDswxgL4AX9u4vHS&_nc_zt=23&_nc_ht=scontent.fcmb11-1.fna&oh=00_AfBYQKG3bLtEGDFILG06pxjrtFT4k3vBGe1exutH1G3dxw&oe=64AB620D',
                            fit: BoxFit.cover),
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19.0),
                        child: Image.network(
                            'https://scontent.fcmb11-1.fna.fbcdn.net/v/t39.30808-6/328534984_759071235387809_2826398565374719523_n.jpg?_nc_cat=109&cb=99be929b-3346023f&ccb=1-7&_nc_sid=0debeb&_nc_eui2=AeENcIs39satwtWjUIsA5pNUlJq8ggUxsEqUmryCBTGwSlgj6gJsaOkXB0DRKJF1eC5gEOyRrxqj9_vid891p2R8&_nc_ohc=_mW6Fjr5bWAAX_gjiLb&_nc_zt=23&_nc_ht=scontent.fcmb11-1.fna&oh=00_AfA864Q-9tZ9cLf7nDjChRGlTHwYChVkDYFORAoJgxT29g&oe=64AB3EFB',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      height: 43,
                    )
                  ]),
            )
          ],
        )),
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

  Future<String> uploadImage(
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
