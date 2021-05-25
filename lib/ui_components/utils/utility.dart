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

  static String getFormattedDateString(DateTime val) {
    String monthName;
    switch (val.month) {
      case 1:
        monthName = 'січня';
        break;
      case 2:
        monthName = 'лютого';
        break;
      case 3:
        monthName = 'березня';
        break;
      case 4:
        monthName = 'квітня';
        break;
      case 5:
        monthName = 'травня';
        break;
      case 6:
        monthName = 'червня';
        break;
      case 7:
        monthName = 'липня';
        break;
      case 8:
        monthName = 'серпня';
        break;
      case 9:
        monthName = 'вересня';
        break;
      case 10:
        monthName = 'жовтня';
        break;
      case 11:
        monthName = 'листопада';
        break;
      case 12:
        monthName = 'грудня';
        break;
      default:
        monthName = '???';
        break;
    }
    return '${val.day} $monthName ${val.year}';
  }
}
