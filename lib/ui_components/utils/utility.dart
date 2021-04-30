import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class Utility {
  static Future<String> uploadFile(File file, String storageFolder) async {
    final storage = FirebaseStorage.instance
        .ref()
        .child('$storageFolder/${Path.basename(file.path)}');
    await storage.putFile(file);
    print('${file.path} uploaded');
    return storage.getDownloadURL();
  }
}
