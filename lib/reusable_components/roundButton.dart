import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoundButton extends StatelessWidget {
  final String labelText;
  final Function() onPressed;
  final IconData icon;
  // Icon myIcon = Icon(Icons.add);
  const RoundButton({
    super.key,
    required this.labelText,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        minimumSize: const Size(100, 40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(labelText),
        ],
      ),
      onPressed: () async {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          // TODO: Upload the image to your server
        }
      },
    );
  }
}
