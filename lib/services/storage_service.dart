import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFile({
    required String filePath,
  }) async {
    File file = File(filePath);
    final String userStoragePath =
        '${dotenv.env['STORAGE_USER_UPLOAD_FOLDER']}';
    final String fileName =
        '${currentUser.uid}/${DateTime.now().millisecondsSinceEpoch}${p.extension(filePath)}';

    if (userStoragePath.isNotEmpty) {
      try {
        Reference ref = await storage
            .ref('$userStoragePath/$fileName')
            .putFile(file)
            .then((res) => res.ref);
        return ref.fullPath;
      } on FirebaseException catch (e) {
        return Future.error(e.toString());
      }
    } else {
      return Future.error('Storage Reference Error');
    }
  }

  Future<String> getPublicUrl(String pathRef) async {
    try {
      return await storage.ref().child(pathRef).getDownloadURL();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
