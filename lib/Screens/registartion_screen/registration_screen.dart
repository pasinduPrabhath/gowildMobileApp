import 'package:flutter/material.dart';
import 'package:gowild/Screens/registartion_screen/registration_screen_model.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../backend/api_requests/registration_screen_api.dart';
import '/reusable_components/inputFieldRegistration.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:gowild/Screens/registartion_screen/service_provider_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  // final _birthdayController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final _countryController = TextEditingController();
  final _townController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _nicNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isServiceProvider = false;
  late String _firstName = '';
  late String _lastName = '';
  late DateTime _birthday;
  late String _country = '';
  late String _town = '';
  late String _mobileNumber = '';
  late String _gender = '';
  late String _email;
  late String _password;
  late String _nicNumber = '';
  bool _isLoading = false;
  late String frontimageUrl = '';
  late String rearimageUrl = '';
  File _imageFront = File('');
  File _imageRear = File('');
  File _profilePic = File('');
  late String _profilePicUrl = '';

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      _profilePicUrl = await uploadImage(_profilePic, 'profile', 'profilePic');
      print(_profilePicUrl);
      if (_isServiceProvider) {
        frontimageUrl = await uploadImage(_imageFront, 'front', 'nicImages');
        rearimageUrl = await uploadImage(_imageRear, 'rear', 'nicImages');

        final serviceProvider = ServiceProvider(
          firstName: _firstName,
          lastName: _lastName,
          birthday: DateFormat('yyyy-MM-dd').format(_birthday),
          country: _country,
          town: _town,
          mobileNumber: _mobileNumber,
          gender: _gender,
          email: _email,
          password: _password,
          nicNumber: _nicNumber,
          isApproved: 'pending',
          userImageFront: frontimageUrl,
          userImageRear: rearimageUrl,
          profPicUrl: _profilePicUrl,
          timestamp: DateTime.now().toUtc().toString(),
        );

        final spId = await Api.registerServiceProvider(serviceProvider);
        // print(profPicId);
        print(spId);
        if (spId == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Await for the Confirmation. Thank you!'),
            ),
          );
        }

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/');
      }
      final user = User(
        firstName: _firstName,
        lastName: _lastName,
        birthday: DateFormat('yyyy-MM-dd').format(_birthday),
        country: _country,
        town: _town,
        mobileNumber: _mobileNumber,
        gender: _gender,
        email: _email,
        password: _password,
        profPicUrl: _profilePicUrl,
        timestamp: DateTime.now().toUtc().toString(),
      );
      print('going to create user');
      final userId = await Api.createUser(user);
      print('user created');
      if (userId == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User created successfully. Please log in.'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      String errorMessage = 'Failed to create users';
      if (e.toString() == 'Email already registered') {
        errorMessage = 'Email already registered';
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    // _birthdayController.dispose();
    _countryController.dispose();
    _townController.dispose();
    _mobileNumberController.dispose();
    _nicNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // Firebase.initializeApp();
    super.initState();
    _birthday = DateTime.now();
    _gender = 'male';
    _firstNameController.text = _firstName;
    _lastNameController.text = _lastName;
    // _birthdayController.text = DateFormat('dd/MM/yyyy').format(_birthday);
    _countryController.text = _country;
    _townController.text = _town;
    _mobileNumberController.text = _mobileNumber;
    _nicNumberController.text = _nicNumber;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>?;
    _email = args?['name'] ?? '';
    _password = args?['password'] ?? '';
    return Stack(
      children: [
        Scaffold(
          backgroundColor:
              Color.fromRGBO(225, 241, 241, 1), // set background color to dark
          appBar: AppBar(
            title: const Text(
              'You are closer!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              Navigator.pushReplacementNamed(context, '/');
              return false;
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomTextFormField(
                      labelText: 'First Name',
                      errorText: 'Please enter a valid First Name',
                      controller: _firstNameController,
                      onSaved: (value) {
                        _firstName = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormField(
                      labelText: 'Last Name',
                      controller: _lastNameController,
                      errorText: 'Please enter a valid Last Name',
                      onSaved: (value) {
                        _lastName = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        SizedBox(
                          height: 45,
                          child: InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _birthday,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.dark(),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null && picked != _birthday) {
                                setState(() {
                                  _birthday = picked;
                                  _birthdayController.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(_birthday);
                                });
                              }
                            },
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _birthdayController,
                                decoration: const InputDecoration(
                                  labelText: 'Birthday',
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 10, 10, 10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your birthday';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _birthday =
                                      DateFormat('dd/MM/yyyy').parse(value!);
                                },
                                onTap: () {
                                  print('tapped');
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      labelText: 'Country',
                      controller: _countryController,
                      errorText: 'Please enter a valid Country name',
                      onSaved: (value) {
                        _country = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormField(
                      labelText: 'Town',
                      controller: _townController,
                      errorText: 'Please enter a valid Town name',
                      onSaved: (value) {
                        _town = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormField(
                      labelText: 'Mobile Number',
                      controller: _mobileNumberController,
                      errorText: 'Please enter a valid Mobile Number',
                      onSaved: (value) {
                        _mobileNumber = value;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    Text('Gender',
                        style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => Colors.black,
                          ),
                          value: 'male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value as String;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio(
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => Colors.black,
                          ),
                          value: 'female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value as String;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text('Are you a service provider?',
                        style: Theme.of(context).textTheme.titleMedium),
                    Row(
                      children: <Widget>[
                        Radio(
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => Colors.black,
                          ),
                          value: true,
                          groupValue: _isServiceProvider,
                          onChanged: (value) {
                            setState(() {
                              _isServiceProvider = value as bool;
                            });
                          },
                        ),
                        const Text('Yes'),
                        Radio(
                          fillColor: MaterialStateProperty.resolveWith<Color?>(
                            (states) => Colors.black,
                          ),
                          value: false,
                          groupValue: _isServiceProvider,
                          onChanged: (value) {
                            setState(() {
                              _isServiceProvider = value as bool;
                            });
                          },
                        ),
                        const Text('No'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text('Add a Profile Picture',
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 22, 65, 102),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width * 0.3, 45),
                            ),
                          ),
                          onPressed: () async {
                            final file = await pickImage();
                            setState(() {
                              _profilePic = file!;
                            });
                          },
                          child: const Text(
                            'Select an Image',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    if (_isServiceProvider)
                      Column(
                        children: [
                          CustomTextFormField(
                            labelText: 'NIC Number',
                            controller: _nicNumberController,
                            errorText: 'Please enter a valid NIC number',
                            onSaved: (value) {
                              _nicNumber = value;
                            },
                            keyboardType: TextInputType.name,
                          ),
                          Text('Upload Copy of Your NIC',
                              style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 22, 65, 102),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width * 0.3,
                                    45),
                              ),
                            ),
                            onPressed: () async {
                              final file = await pickImage();
                              setState(() {
                                _imageFront = file!;
                              });
                            },
                            child: const Text(
                              'Front Side',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.006,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 22, 65, 102),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width * 0.3,
                                    45),
                              ),
                            ),
                            onPressed: () async {
                              final file = await pickImage();
                              setState(() {
                                _imageRear = file!;
                              });
                            },
                            child: const Text(
                              'Back Side',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 22, 65, 102)),
                      ),
                      onPressed: _submitForm,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      // You can access the form data using the variables declared above
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: const Color.fromARGB(255, 3, 3, 3).withOpacity(0.9),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Registering in Progress!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
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
      File imageFile, String suffix, String imageCategory) async {
    // ImagePicker imagePicker = ImagePicker();
    File? file = imageFile;
    if (file == null) {
      throw Exception('No image selected');
    }
    String uniqueFileName =
        suffix + DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference fileReference =
        referenceRoot.child('$imageCategory/$_email/$uniqueFileName');
    try {
      await fileReference.putFile(File(file.path));
      final imageUrl = await fileReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
      throw Exception('Failed to upload image');
    }
  }
}
