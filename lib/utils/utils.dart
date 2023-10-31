import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (file != null && file.files.isNotEmpty) {
      for (int i = 0; i < file.files.length; i++) {
        images.add(File(file.files[i].path!));
      }
    } else {
      // Handle the case when no files were selected, e.g., show a message.
      debugPrint("No images selected.");
    }
  } catch (e) {
    debugPrint("pickImage error => ${e.toString()}");
  }
  return images;
}


// Future<List<File>> pickImages() async {
//   List<File> images = [];

//   try {
//     var file = await FilePicker.platform
//         .pickFiles(type: FileType.image, allowMultiple: true);
//     if (file != null && file.files.isNotEmpty) {
//       for (int i = 0; i < file.files.length; i++) {
//         images.add(File(file.files[i].path!));
//       }
//     }
//   } catch (e) {
//     debugPrint(e.toString());
//   }
//   return images;
// }
