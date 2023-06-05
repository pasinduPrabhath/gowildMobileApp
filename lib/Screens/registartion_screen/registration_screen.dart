// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gowild/Screens/registartion_screen/registration_screen_model.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../backend/api_requests/registration_screen_api.dart';
import '/reusable_components/inputFieldRegistration.dart';
import 'package:image_picker/image_picker.dart';
import '../../reusable_components/roundButton.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isServiceProvider = false;
  late String _firstName = '';
  late String _lastName;
  late DateTime _birthday;
  late String _country;
  late String _town;
  late String _mobileNumber;
  late String _gender = '';
  late String _email;
  late String _password;
  late String _nicNumber;
  // late String _timestamp;
  bool _isLoading = false;

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });
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
      nicNumber: _nicNumber,
      sp: _isServiceProvider,
      timestamp: DateTime.now().toUtc().toString(),
    );
    try {
      final userId = await Api.createUser(user);
      print('user id is $userId');

      if (userId == 1) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User created successfully. Please log in.'),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create user'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _birthday = DateTime.now();
    _gender = 'male';
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
          backgroundColor: Colors.grey[900], // set background color to dark
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
                      onSaved: (value) {
                        _firstName = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormField(
                      labelText: 'Last Name',
                      errorText: 'Please enter a valid Last Name',
                      onSaved: (value) {
                        _lastName = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
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
                                });
                              }
                            },
                            child: IgnorePointer(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Birthday',
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: DateFormat('dd/MM/yyyy')
                                      .format(_birthday),
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
                      errorText: 'Please enter a valid Country name',
                      onSaved: (value) {
                        _country = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormField(
                      labelText: 'Town',
                      errorText: 'Please enter a valid Town name',
                      onSaved: (value) {
                        _town = value;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextFormField(
                      labelText: 'Mobile Number',
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
                    if (_isServiceProvider)
                      Column(
                        children: [
                          CustomTextFormField(
                            labelText: 'NIC Number',
                            errorText: 'Please enter a valid NIC number',
                            onSaved: (value) {
                              value = _nicNumber;
                            },
                            keyboardType: TextInputType.name,
                          ),
                          Text('Upload Copy of Your NIC',
                              style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundButton(
                                    labelText: 'Front Side',
                                    icon: Icons.upload_file,
                                    onPressed: () async {
                                      final pickedFile = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (pickedFile != null) {
                                        // TODO: Upload the image to your server
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundButton(
                                    labelText: 'Back Side',
                                    icon: Icons.upload_file,
                                    onPressed: () async {
                                      final pickedFile = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (pickedFile != null) {
                                        // TODO: Upload the image to your server
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      // TODO: Save registration data to database
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
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
