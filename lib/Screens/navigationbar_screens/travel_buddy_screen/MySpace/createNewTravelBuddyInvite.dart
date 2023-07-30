import 'package:flutter/material.dart';
import 'package:gowild/Screens/navigationbar_screens/travel_buddy_screen/MySpace/travelBuddyModel.dart';
import 'package:gowild/backend/api_requests/client_api.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewTravelBuddyInvite extends StatefulWidget {
  const CreateNewTravelBuddyInvite({super.key});

  @override
  State<CreateNewTravelBuddyInvite> createState() =>
      _CreateNewTravelBuddyInviteState();
}

class _CreateNewTravelBuddyInviteState
    extends State<CreateNewTravelBuddyInvite> {
  // final TextEditingController _titleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _requestContentController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _noOfParticipantsController =
      TextEditingController();
  String errorMessage = 'Fill all the fields';
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  bool _isLoading = false;
  DateTime? _selectedDate;
  late String email;
  late DateTime _birthday;
  void getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    print(email);
  }

  void _submitAd() async {
    if (_formKeys.currentState == null || !_formKeys.currentState!.validate()) {
      return;
    }
    _formKeys.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final travelBuddy = TravelBuddyModel(
        email: email,
        place: _placeController.text,
        district: _districtController.text,
        date: _dateController.text,
        content: _requestContentController.text,
        noOfParticipants: int.parse(_noOfParticipantsController.text),
        timestamp: DateTime.now().toUtc().toString(),
      );
      print(travelBuddy);
      final adId = await ClientAPI.createTravelBuddyReq(travelBuddy);
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
    _phoneNumberController.dispose();
    _placeController.dispose();
    _dateController.dispose();
    _districtController.dispose();
    _requestContentController.dispose();
    _noOfParticipantsController.dispose();
    super.dispose();
  }

  void initState() {
    print('intied');
    _districtController.text = 'Ampara';
    _birthday = DateTime.now();
    // _categoryController.text = 'Safari';
    print('get email');
    getEmail();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var _selectedDate;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Tour Invitation'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKeys,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 25),
                    child: Text(
                      'Place :',
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
                      controller: _placeController,
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
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 10, top: 3),
                        child: Text(
                          'Date:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: SizedBox(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        child: InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _birthday,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now().add(Duration(days: 90)),
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
                                _dateController.text =
                                    DateFormat('yyyy/MM/dd').format(_birthday);
                              });
                            }
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: _dateController,
                              decoration: const InputDecoration(
                                // labelText: 'Birthday',
                                hintStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900),
                                hintText: 'Enter the planned date',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 153, 151, 151),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the planned date';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _birthday =
                                    DateFormat('yyyy/MM/DD').parse(value!);
                                // print(_birthday);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      'Content :',
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
                        controller: _requestContentController,
                        maxLength: 580,
                        decoration: const InputDecoration(
                          hintText: 'Enter the content for the invitation',
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
                      'Number of participants :',
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
                      controller: _noOfParticipantsController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter participant count',
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
                          return 'Please enter participant count';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid participant count';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Center(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 22, 65, 102)),
                        ),
                        onPressed: () {
                          _submitAd();
                          // if (_formKey.currentState!.validate()) {}
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
