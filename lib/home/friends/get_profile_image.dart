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
    print(downloadURL);
    return downloadURL;
  }

  Future<String> getFriendsImageFromFirebase(String username) async{
    String test1 = "";
    await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get().then((event) {
      event.docs.forEach((element) {
        test1 = element["profilePicture"];
      });
    });

    return getImageFromFirebase(test1);
  }
}