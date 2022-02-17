import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/entity/debt_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class DataRepository {

  final CollectionReference collection = FirebaseFirestore.instance.collection("users");
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Stream<DocumentSnapshot> getStream() {
    return collection.doc(firebaseUser!.uid).snapshots();
  }

  void addUser(DebtUser user) async{
    await collection.doc(firebaseUser!.uid).set(user.toJson());
  }

  void updateUser(DebtUser user) async{
    await collection.doc(firebaseUser!.uid).update(user.toJson());
  }

  Stream<QuerySnapshot> getUsernames(String username) {
    username = "hiebeler05";
    return collection.where("username", isEqualTo: username).snapshots();
  }

}