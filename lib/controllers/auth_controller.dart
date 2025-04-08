import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthController {
  Future<String> createNewUser({
    required String email,
    required String fullName,
    required String password,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String res = 'some error Occurred ';
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
