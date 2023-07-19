import 'package:flutter/material.dart';

import '../../../reusable_components/inputFieldRegistration.dart';
import '../../../reusable_components/roundButton.dart';

class AddNewAd extends StatefulWidget {
  const AddNewAd({super.key});

  @override
  State<AddNewAd> createState() => _AddNewAdState();
}

class _AddNewAdState extends State<AddNewAd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  String? selectedDistrict = 'District 1';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post an ad'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Choose an option to post an ad:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Text(
                'Title :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: SizedBox(
                width: size.width * 0.4,
                // height: size,
                child: CustomTextFormField(
                  labelText: 'Title',
                  controller: _titleController,
                  errorText: 'Please enter a title',
                  onSaved: null,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5.0),
              child: Text(
                'Town :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: SizedBox(
                width: size.width * 0.4,
                // height: size,
                child: const CustomTextFormField(
                  labelText: 'Town',
                  controller: null,
                  errorText: 'Please enter a Town',
                  onSaved: null,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5.0),
              child: Text(
                'District :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
                width:
                    10), // Add some spacing between the label and the dropdown
            Padding(
              padding: const EdgeInsets.only(left: 22.0, bottom: 10),
              child: DropdownButton<String>(
                value: selectedDistrict,
                onChanged: (String? newValue) {
                  print('Selected district: $newValue');
                  setState(() {
                    selectedDistrict = newValue;
                    _townController.text = newValue ?? '';
                  });
                },
                items: <String>[
                  'District 1',
                  'District 2',
                  'District 3',
                  'District 4',
                  'District 5'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5.0),
              child: Text(
                'Price :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: SizedBox(
                width: size.width * 0.4,
                // height: size,
                child: const CustomTextFormField(
                  labelText: 'Price',
                  controller: null,
                  errorText: 'Please enter a Price',
                  onSaved: null,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 5.0),
                  child: Text(
                    'Description :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, bottom: 20),
              child: SizedBox(
                width: size.width * 0.7,
                // height: size.height * 0.2,
                child: const TextField(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  // controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter a description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5.0),
              child: Text(
                'Phone Number :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: SizedBox(
                width: size.width * 0.4,
                // height: size,
                child: const CustomTextFormField(
                  labelText: 'Phone Number',
                  controller: null,
                  errorText: 'Please enter a Phone Number',
                  onSaved: null,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: SizedBox(
                    width: size.width * 0.2,
                    child: const Center(child: Text('Post an ad')),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
