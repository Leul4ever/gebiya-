import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> createNewUser({
    required String email,
    required String fullName,
    required String password,
  }) async {
    String res = 'some error Occurred';
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Store user data in Firestore
      await _firebaseFirestore
          .collection('buyers')
          .doc(userCredential.user!.uid)
          .set({
            'fullName': fullName,
            'email': email,
            'buyerId': userCredential.user!.uid,
          });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
