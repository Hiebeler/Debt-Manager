import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GetProfileImage {
  Future<String> getImageFromFirebase(String? url) async {
    String downloadURL;
    print(url);
    if (url == null) return "";
    try {
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(url)
          .getDownloadURL();
    } on FirebaseException catch (e) {
      return "";
    }
    return downloadURL;
  }
}