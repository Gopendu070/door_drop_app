import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/partner/partner_login_page.dart';
import 'package:door_drop/views/user/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AppLandingPage extends StatelessWidget {
  const AppLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var h = 170.0;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              const Color.fromARGB(255, 42, 18, 111),
              Colors.black87
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Door Drop!",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "\"Making each delivery hassle-free\"",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 180),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LoginCard(
                  h: h,
                  label: "Partner  login",
                  path: "asset/delivery.json",
                  func: () {
                    Get.to(PartnerLoginPage());
                  },
                ),
                LoginCard(
                  h: h,
                  label: "Customer login",
                  path: "asset/user.json",
                  func: () {
                    Get.to(UserLoginPage());
                  },
                ),
              ],
            ),
            SizedBox(height: 180),
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.h,
    required this.label,
    required this.path,
    required this.func,
  });

  final double h;
  final String label;
  final String path;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: func,
          child: Container(
            height: h,
            width: h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromARGB(245, 173, 49, 195))),
            child: Lottie.asset(path, fit: BoxFit.contain),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
