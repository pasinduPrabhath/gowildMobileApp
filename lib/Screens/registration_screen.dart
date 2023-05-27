import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/reusable_components/inputFieldRegistration.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _firstName;
  late String _lastName;
  late DateTime _birthday;
  late String _country;
  late String _town;
  late String _mobileNumber;
  late String _gender;
  late String _email;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthday,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
    }
  }

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
                labelText: 'Moile Number',
                errorText: 'Please enter a valid email address',
                onSaved: (value) {
                  value = _mobileNumber;
                },
              ),
              CustomTextFormField(
                labelText: 'Gender',
                errorText: 'Please select the Gender',
                onSaved: (value) {
                  value = _gender;
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Save registration data to database
                    // You can access the form data using the variables declared above
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
