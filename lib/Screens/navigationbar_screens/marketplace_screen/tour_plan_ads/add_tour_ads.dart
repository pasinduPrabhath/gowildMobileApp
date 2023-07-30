import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/marketplace_screen/tour_plan_ads/AddTourAdsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../../../backend/api_requests/serviceProvider_api.dart';

class AddTourAds extends StatefulWidget {
  const AddTourAds({super.key});

  @override
  State<AddTourAds> createState() => _AddTourAdsState();
}

class _AddTourAdsState extends State<AddTourAds> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _fulldaypriceController = TextEditingController();
  final TextEditingController _halfdaypriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String errorMessage = 'Fill all the fields';
  bool isSwitched = false;

  final _formKey = GlobalKey<FormState>();
  List<File> imageFiles = []; // List to store the selected image files
  final picker = ImagePicker(); // Image picker instance
  bool _isLoading = false;
  late String email;

  Future<void> _selectImages() async {
    if (imageFiles.length >= 4) {
      return; // Limit the number of images that can be selected to 4
    }
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 20,
    );
    if (pickedFiles != null) {
      setState(() {
        imageFiles.addAll(
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
      });
    }
  }

  Future<List<String>> uploadImages(List<File> imageFiles, String suffix,
      String imageCategory, String category) async {
    List<String> imageUrls = [];
    Reference referenceRoot = FirebaseStorage.instance.ref();
    for (int i = 0; i < imageFiles.length; i++) {
      File? file = imageFiles[i];
      if (file == null) {
        throw Exception('No image selected');
      }
      String uniqueFileName = suffix +
          DateTime.now().millisecondsSinceEpoch.toString() +
          i.toString();
      Reference fileReference = referenceRoot.child(
          '$imageCategory/tourAds/$category/$email/$suffix/$uniqueFileName');
      try {
        await fileReference.putFile(File(file.path));
        final imageUrl = await fileReference.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print(e);
        throw Exception('Failed to upload image');
      }
    }
    return imageUrls;
  }

  @override
  void initState() {
    print('intied');
    _districtController.text = 'Ampara';
    _categoryController.text = 'Safari';
    getEmail();
    super.initState();
  }

  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    print(email);
  }

  void _submitAd() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      print('going to upload images');
      final imageUrls = await uploadImages(
          imageFiles,
          _titleController.text,
          'marketplace',
          _categoryController.text); // Upload images to firebase storage
      final tourAds = AddTourAdsModel(
        adType: _categoryController.text,
        email: email,
        title: _titleController.text,
        town: _townController.text,
        district: _districtController.text,
        priceFull: int.parse(_fulldaypriceController.text),
        priceHalf: int.parse(_halfdaypriceController.text),
        description: _descriptionController.text,
        phoneNum: int.parse(_phoneNumberController.text),
        imageLinks: imageUrls,
        timestamp: DateTime.now().toUtc().toString(),
      );

      print('image urls: $imageUrls');
      // print(marketPlaceAdd.toMap());
      final adId = await SpAPI.createTourAd(tourAds);
      print('Ad created with id: $adId');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ad posted successfully'),
        ),
      );
    } catch (e) {
      if (e.toString() == 'Database connection error') {
        errorMessage = 'Enter Correct inputs';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _townController.dispose();
    _fulldaypriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _categoryController.text = 'Safari';
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a new service'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Category :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22.0, top: 10, right: 22),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 148, 144, 144),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 3),
                        child: DropdownButtonFormField<String>(
                          value:
                              _categoryController.text, // Set the initial value
                          menuMaxHeight: size.height * 0.3,
                          onChanged: (String? newValue) {
                            setState(() {
                              _categoryController.text = newValue ??
                                  ''; // Update the controller's text
                            });
                          },
                          items: <String>["Safari", "Food", "Lodging", "Rent"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a district';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Title for the service :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22.0, right: 22, top: 10),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900),
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        hintText: 'Enter a title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Town / Place :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22.0, right: 22, bottom: 25, top: 10),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900),
                      controller: _townController,
                      decoration: const InputDecoration(
                        hintText: 'Enter place',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a town';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'District :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22.0, top: 10, bottom: 25, right: 22),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 148, 144, 144),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 3),
                        child: DropdownButtonFormField<String>(
                          value:
                              _districtController.text, // Set the initial value
                          menuMaxHeight: size.height * 0.3,
                          onChanged: (String? newValue) {
                            setState(() {
                              _districtController.text = newValue ??
                                  ''; // Update the controller's text
                            });
                          },
                          items: <String>[
                            "Ampara",
                            "Anuradhapura",
                            "Badulla",
                            "Batticaloa",
                            "Colombo",
                            "Galle",
                            "Gampaha",
                            "Hambantota",
                            "Jaffna",
                            "Kalutara",
                            "Kandy",
                            "Kegalle",
                            "Kilinochchi",
                            "Kurunegala",
                            "Mannar",
                            "Matale",
                            "Matara",
                            "Monaragala",
                            "Mullaitivu",
                            "Nuwara Eliya",
                            "Polonnaruwa",
                            "Puttalam",
                            "Ratnapura",
                            "Trincomalee",
                            "Vavuniya"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a district';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Price Variation:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor:
                            const Color.fromARGB(255, 57, 181, 230),
                        activeColor: const Color.fromARGB(255, 53, 123, 144),
                      ),
                    ],
                  ),
                  Row(
                    // Use Row to display fields side by side
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 22.0,
                            left: 22,
                            bottom: 25,
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                            controller:
                                _fulldaypriceController, // You need to create a new TextEditingController for the half day price
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Full day price',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              try {
                                int.parse(value);
                              } catch (e) {
                                errorMessage = 'Enter Correct type of inputs';
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a price';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid price';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      if (isSwitched)
                        Expanded(
                          // Use Expanded to make sure the fields take equal space
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 22.0, left: 5, bottom: 25, top: 10),
                            child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w900),
                              controller: _halfdaypriceController,
                              keyboardType: TextInputType.number,
                              initialValue: '0',
                              decoration: const InputDecoration(
                                hintText: 'Half day price',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                try {
                                  // if (value.isEmpty) {
                                  //   value = '0';
                                  // }
                                  print('calling onchange');
                                  int.parse(value);
                                } catch (e) {
                                  errorMessage = 'Enter Correct type of inputs';
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  value = '0';
                                  print('value is $value');
                                }
                                if (value!.contains(RegExp(r'[^\d]'))) {
                                  return 'Please enter a valid price';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      'Description :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22.0,
                      right: 22,
                    ),
                    child: SizedBox(
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w900),
                        controller: _descriptionController,
                        maxLength: 300,
                        decoration: const InputDecoration(
                          hintText: 'Enter a description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Phone Number :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22.0, right: 22, bottom: 25, top: 10),
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900),
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter a number',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        try {
                          int.parse(value);
                          errorMessage = 'Fill all the fields';
                        } catch (e) {
                          errorMessage = 'Enter Correct type of inputs';
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Photos :',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageFiles.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0 && imageFiles.length <= 4) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: _selectImages,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                              ),
                            );
                          } else {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Image.file(
                                      imageFiles[index - 1],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        imageFiles.removeAt(index - 1);
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(82, 191, 216, 245),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Color.fromARGB(255, 102, 96, 96),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 20),
                    child: Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 22, 65, 102)),
                        ),
                        onPressed: () {
                          if (_halfdaypriceController.text.isEmpty) {
                            _halfdaypriceController.text = '0';
                          }
                          if (_formKey.currentState!.validate()) {
                            _submitAd();
                          }
                        },
                        child: SizedBox(
                          width: size.width * 0.15,
                          child: const Center(
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              height: size.height,
              width: size.width,
              color: Colors.black.withOpacity(0.8),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
