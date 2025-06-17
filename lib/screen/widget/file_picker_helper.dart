import 'dart:io' show File;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;

class FilePickerHelper {
  static Future<dynamic> pickImageFile() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      print('Result is: $result');
      if (result != null && result.files.isNotEmpty) {
        final fileData = result.files.single;
        print('File data: $fileData');
        print('File name: ${fileData.name}');
        if (fileData.bytes != null) {
          final bytes = fileData.bytes!;
          final name = fileData.name;
          final blob = html.Blob([bytes]);
          final file = html.File([blob], name);
          return file;
        }
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      print('Result is: $result');
      if (result != null && result.files.isNotEmpty) {
        final path = result.files.single.path;
        print('File path: $path');
        if (path != null) {
          return File(path);
        }
      }
    }
    return null;
  }

}
