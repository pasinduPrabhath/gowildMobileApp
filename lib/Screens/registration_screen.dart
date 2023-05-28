import 'package:flutter/material.dart';
import 'package:gowild/routes/routes.dart';
import 'package:gowild/screens/login_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '/reusable_components/inputFieldRegistration.dart';
import 'HomeScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../reusable_components/roundButton.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isServiceProvider = false;
  late String _firstName;
  late String _lastName;
  late DateTime _birthday;
  late String _country;
  late String _town;
  late String _mobileNumber;
  late String _gender = '';
  late String _email;
  late String _nicNumber;

  @override
  void initState() {
    super.initState();
    _birthday = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // set background color to dark
      appBar: AppBar(
        title: const Text(
          'You are closer!',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
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
                    value = _firstName;
                  }),
              CustomTextFormField(
                  labelText: 'Last Name',
                  errorText: 'Please enter a valid Last Name',
                  onSaved: (value) {
                    value = _lastName;
                  }),
              CustomTextFormField(
                labelText: 'Email',
                errorText: 'Please enter a valid email address',
                onSaved: (value) {
                  value = _email;
                },
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
                            text: DateFormat('dd/MM/yyyy').format(_birthday),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your birthday';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _birthday = DateFormat('dd/MM/yyyy').parse(value!);
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
                  value = _country;
                },
              ),
              CustomTextFormField(
                labelText: 'Town',
                errorText: 'Please enter a valid Town name',
                onSaved: (value) {
                  value = _town;
                },
              ),
              CustomTextFormField(
                labelText: 'Mobile Number',
                errorText: 'Please enter a valid email address',
                onSaved: (value) {
                  value = _mobileNumber;
                },
              ),
              Text('Gender', style: Theme.of(context).textTheme.subtitle1),
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
                  style: Theme.of(context).textTheme.subtitle1),
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
                    ),
                    Text('Upload Copy of Your NIC',
                        style: Theme.of(context).textTheme.subtitle1),
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
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  // TODO: Upload the image to your server
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundButton(
                              labelText: 'Back Side',
                              icon: Icons.upload_file,
                              onPressed: () async {
                                final pickedFile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
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
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   // TODO: Save registration data to database
                  //   // You can access the form data using the variables declared above
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
