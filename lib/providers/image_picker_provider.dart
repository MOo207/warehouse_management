import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? _chosenImage;
  File? get chosenImage => _chosenImage;

  String? _chosenImagePath;
  String? get chosenImagePath => _chosenImagePath;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
        source: source, imageQuality: 100, maxHeight: 300, maxWidth: 300);
    if (pickedFile != null) {
      _chosenImage = File(pickedFile.path);
      File? compressedImage = await compressImage(_chosenImage!);
// getting a directory path for saving
      final Directory directory = await getApplicationDocumentsDirectory();
      final String directoryPath = directory.path;
      String fullPath =
          '$directoryPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
// copy the file to a new path
      await compressedImage!.copy(fullPath);
    }
    notifyListeners();
  }

  // compress file and get file.
  Future<File?> compressImage(File image) async {
    // original file path
    final filePath = image.absolute.path;
    // creating output path
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final split = filePath.substring(0, (lastIndex));
    final outPath = "${split}_out${filePath.substring(lastIndex)}";

    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 50,
    );
    print("Original : ${image.lengthSync() / 1024}");
    print("Compressed: ${result!.lengthSync() / 1024}");

    return result;
  }
}
