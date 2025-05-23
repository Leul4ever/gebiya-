import 'package:ecommerce/controllers/auth_controller.dart';
import 'package:ecommerce/views/screens/map_screen.dart';
import 'package:ecommerce/views/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool _isLoading = false;
  loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await _authController.loginUser(email, password);
      // The _isLoading variable is necessary to manage the loading state of the UI,
      // indicating to the user that a login process is ongoing. This prevents
      // multiple submissions and enhances user experience.
      setState(() {
        _isLoading =
            false; // Corrected the variable name to match the defined variable
      });
      if (res == 'success') {
        Get.to(MapScreen());
        Get.snackbar(
          'login success',
          'You are now Logged in ',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error Occurred',
          res.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login Account  ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Email Address'; // <-- semicolon added here
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(label: Text('Email')),
              ),

              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter The password Must Not Be Empty";
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text('Password')),
                obscureText: true,
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () => {loginUser()},
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                        _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                              "login",
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
                onPressed: () {
                  Get.to(RegisterScreen());
                },
                child: Text('Need an account '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
