import 'dart:typed_data'; // Changed from the internal VM library

import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/views/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String fullName;
  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  captureImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 30.0,
          bottom: 10.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  _image == null
                      ? CircleAvatar(
                        radius: 56,
                        child: Icon(Icons.person, size: 70),
                      )
                      : CircleAvatar(
                        radius: 56,
                        backgroundImage: MemoryImage(_image!),
                      ),
                  Positioned(
                    right: 0,
                    top: 20,
                    child: IconButton(
                      icon: Icon(CupertinoIcons.photo),
                      onPressed: () {
                        selectGalleryImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Email Address must Not Be Empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Email'),
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  fullName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Full name must not be empty';
                  }
                  if (value.length < 3) {
                    return 'Full name must be at least 3 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Full name'),
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) => password = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password must not be empty';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Password'),
                  hintText: 'Password ',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  print('Register button clicked');
                  if (_formKey.currentState!.validate()) {
                    _authController.createNewUser(
                      email: email,
                      fullName: fullName,
                      password: password,
                    );
                    print('successfully registered');
                  } else {
                    print('Not Validate');
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    ),
                child: Text('Already Have An Account '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
