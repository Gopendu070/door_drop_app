import 'package:door_drop/app_style/AppStyle.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        "The Smart Delivery Drop Box system ensures secure, convenient package delivery and storage, eliminating missed deliveries. Installed at homes or businesses, it features a secure compartment for couriers to deposit packages using unique access codes. Recipients retrieve packages via personalized codes or mobile app authentication. With real-time tracking and integrated security features like cameras and motion detectors, it offers safe, hassle-free package management and protection against theft or tampering.";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About us",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Appstyle.appBackGround,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber)),
          child: Text(
            data,
            textAlign: TextAlign.justify,
            style:
                Appstyle.whiteText.copyWith(color: Colors.amber, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
