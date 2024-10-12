import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tako_food/provider/user_provider.dart';
import 'package:tako_food/model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<User?> registerWithEmailUserAndPass(
    String email,
    String name,
    String pass,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? user = result.user;

      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'profile_pic': "",
        });
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> sendEmailforResetPassword(String email) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<Map<String, dynamic>?> getData(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (data.exists) {
      return data as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> fetchUserData(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (currentUser != null) {
      String uid = currentUser.uid;
      Map<String, dynamic>? userData = await getData(uid);

      if (userData != null) {
        UserModel userModel = UserModel.fromMap(userData);
        userProvider.setUser(userModel);
      }
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
