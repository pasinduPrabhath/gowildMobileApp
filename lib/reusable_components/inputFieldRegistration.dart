// ignore: file_names
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final Function(String)? onSaved;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.errorText,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 255, 255, 255),
                width: 1.0,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return errorText;
            }
            return null;
          },
          onSaved: (String? value) => onSaved!(value!),
        ),
        SizedBox(
            height:
                MediaQuery.of(context).size.height * 0.03), // Add spacing here
      ],
    );
  }
}
