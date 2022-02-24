import 'dart:async';

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

  Future<DocumentSnapshot> getCurrentDocument() {
    return collection.doc(firebaseUser!.uid).get();
  }

  void addUser(DebtUser user) async{
    await collection.doc(firebaseUser!.uid).set(user.toJson());
  }

  void updateUser(DebtUser user) async{
    await collection.doc(firebaseUser!.uid).update(user.toJson());
  }

  Stream<QuerySnapshot> getUsernames(String username) {
    return collection.where("username", isGreaterThanOrEqualTo: username).where("username", isLessThan: username + "z").snapshots();
  }

  Future<QuerySnapshot> getFriendsFromUsername(String username) {
    return collection.where("username", isEqualTo: username).get();
  }

  Stream<QuerySnapshot> getStreamFriendRequests(String username) {
    return collection.where("friendRequests", arrayContains: {"uid": username}).snapshots();
  }

  Stream<DocumentSnapshot> getStreamFriends(String friendsUid) {
    return collection.doc(friendsUid).snapshots();
  }

  Future<DocumentSnapshot> getFutureFriends(String friendsUid) {
    return collection.doc(friendsUid).get();
  }

/*  Stream<List> getFriendsDebts(String uid) {
    getStream().listen((event) {
      List friends = event["friends"];
      friends.forEach((element) async{
        await getFutureFriends(element["uid"]).then((value) {
          List everyFriendsDebts = value["friendsDebts"];
          everyFriendsDebts.forEach((element) {
            if (element["friendsUid"] == uid) {
              friendDebts.add(element);
            }
          });
        });
      });
    });
  return friendDebts;
  }*/
}