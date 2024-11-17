import 'dart:async';

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/partner/partner_home.dart';
import 'package:door_drop/views/partner/partner_signup_page.dart';
import 'package:door_drop/views/user/user_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PartnerLoginPage extends StatefulWidget {
  @override
  _PartnerLoginPageState createState() => _PartnerLoginPageState();
}

class _PartnerLoginPageState extends State<PartnerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      //todo
      SharedPrefHelper.setIsPartnerTrue();
      SharedPrefHelper.setIsLoggedInTrue();
      if (email == SharedPrefHelper.getPartnerEmail() &&
          password == SharedPrefHelper.getPartnerPassword()) {
        Timer(Duration(seconds: 2), () {
          Get.offAll(PartnerHome());
        });
      } else {
        Fluttertoast.showToast(msg: "User doesn't exist");
      }
    }
  }

  bool isPwVisible = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: height,
            ),
            ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                height: height * 0.75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 143, 35, 162),
                      const Color.fromARGB(255, 87, 48, 155)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              hintText: 'Enter your email',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !isPwVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPwVisible = !isPwVisible;
                                  });
                                },
                                icon: Icon(!isPwVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              hintText: 'Enter your password',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'Password must be 8 digit';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.0),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 50.0),
                            ),
                            child:
                                Text('Login', style: TextStyle(fontSize: 18)),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.8,
              child: Container(
                width: width,
                child: Column(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(PartnerSignupPage(),
                              transition: Transition.noTransition);
                        },
                        child: Text("Sign Up"))
                  ],
                ),
              ),
            ),
            Positioned(
                top: 25,
                left: 8,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      "Partner login",
                      style: Appstyle.whiteText
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}

// Custom Clipper for the bottom wave shape
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80); // Start from the bottom left corner
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point
      size.width, size.height - 20, // End point
    );
    path.lineTo(size.width, 0); // Top right corner
    path.close(); // Close the path to form the shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
