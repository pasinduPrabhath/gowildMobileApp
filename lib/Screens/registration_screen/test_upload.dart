import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                print('${file!.path}');

                // if (file != null) return;
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference fileReference =
                    referenceRoot.child('images/$uniqueFileName');
                try {
                  await fileReference.putFile(File(file!.path));
                  imageUrl = await fileReference.getDownloadURL();
                  print('added + $imageUrl');
                } catch (e) {
                  print('error');
                }
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
