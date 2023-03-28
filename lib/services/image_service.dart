import 'dart:io';

import 'package:dokudoku/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<File?> imagePicker({required ImageSource source}) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 75,
      maxHeight: 320,
      maxWidth: 640,
    );

    if (pickedImage != null) {
      return File(pickedImage.path.toString());
    } else {
      return null;
    }
  }

  static Future<String> getImageUrl({required String imageRef}) async {
    List<String> image = imageRef.split('::');
    if (image[0] == 'url') {
      return image[1];
    } else if (image[0] == 'gs') {
      String url = '';
      await StorageService()
          .getPublicUrl(image[1])
          .then((value) => url = value)
          .catchError((_) => url = '');
      if (url.isNotEmpty) {
        return url;
      } else {
        return Future.error('failed_to_get_public_url');
      }
    } else {
      return image[0];
    }
  }
}
