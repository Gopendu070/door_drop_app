import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/partner/partner_email_verification_page.dart';
import 'package:door_drop/views/user_email_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PartnerSignupPage extends StatefulWidget {
  @override
  _PartnerSignupPageState createState() => _PartnerSignupPageState();
}

class _PartnerSignupPageState extends State<PartnerSignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  var isLoading = false;
  void _signup() async {
    if (_formKey.currentState!.validate()) {
      // Implement login functionality
      final email = _emailController.text;
      final name = _nameController.text;
      final phone = _phoneController.text;
      final password = _passwordController.text;
      setState(() {
        isLoading = !isLoading;
      });
      var partnerSignupResult =
          await apiValues.deliveryBoySignUp(name, email, password, phone);
      if (partnerSignupResult['success']) {
        Fluttertoast.showToast(msg: "OTP sent successfully");
        Get.to(PartnerEmailVerificationPage(
            email: email, password: password, name: name, phone: phone));
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
        );
      }
      setState(() {
        isLoading = !isLoading;
      });
    }
  }

  bool isPwVisible = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(children: [
            Container(
              height: height,
            ),
            ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                height: height * 0.9,
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
                              'Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              hintText: 'Enter your name',
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
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              hintText: 'Enter your phone number',
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
                                return 'Please enter your phone number';
                              } else if (!RegExp(r'^[0-9]{10}$')
                                  .hasMatch(value)) {
                                return 'Phone number must be 10 digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
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
                                  fontSize: 15,
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
                                return 'Password must be 8 digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              'Confirm Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              hintText: 'Re-enter your password',
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
                                return 'Please re-enter your password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords don\'t match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.0),
                          ElevatedButton(
                            onPressed: _signup,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 50.0),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator())
                                : Text('Sign Up',
                                    style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 10,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            )
          ]),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
