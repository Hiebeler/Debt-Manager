import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home/data_repository.dart';
import '../home/entity/debt_user.dart';

class AuthWithGoogle {

  String username = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      print("success google");
      await checkIfUserExists();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future checkIfUserExists() async{
    var firebaseUser = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) {
      if (!value.exists) {
        addUser();
      }
    });
  }

  void addUser() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    final DataRepository repository = DataRepository();
    String? email = _auth.currentUser?.email;
    String username = firebaseUser!.displayName.toString();

    DebtUser user = DebtUser(email: email.toString(), username: username);
    repository.addUser(user);
  }
}