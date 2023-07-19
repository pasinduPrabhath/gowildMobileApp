// ignore: file_names
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final TextEditingController? controller;
  final Function(String)? onSaved;
  final TextInputType keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.errorText,
    required this.onSaved,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            // cursorHeight: 22,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 12, 12, 12), fontSize: 16),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 19, 18, 18),
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
        ),
        SizedBox(
            height:
                MediaQuery.of(context).size.height * 0.03), // Add spacing here
      ],
    );
  }
}
