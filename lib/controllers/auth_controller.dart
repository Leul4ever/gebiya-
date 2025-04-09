import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  // function to  to upload image to firebase storage
  _uploadImageToStorage(Uint8List? image) async {
    Reference ref = _storage
        .ref()
        .child('profileImages')
        .child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> createNewUser({
    required String email,
    required String fullName,
    required String password,
    required Uint8List? image,
  }) async {
    String res = 'some error Occurred';
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String downloadUrl = await _uploadImageToStorage(image);
      // Store user data in Firestore
      await _firebaseFirestore
          .collection('buyers')
          .doc(userCredential.user!.uid)
          .set({
            'fullName': fullName,
            'profileImages': downloadUrl,
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
