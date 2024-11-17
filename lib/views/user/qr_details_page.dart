import 'package:door_drop/app_style/AppStyle.dart';
import 'package:flutter/material.dart';

class QrDetailsPage extends StatelessWidget {
  final String data;
  const QrDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.appBackGround,
      appBar: AppBar(
        title: Text(
          "QR Code Content",
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
      body: Center(
        child: Container(
          width: 340,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [Colors.white12, const Color.fromARGB(45, 0, 0, 0)])),
          padding: EdgeInsets.all(12),
          child: Text(
            data,
            // textAlign: TextAlign.justify,
            style: Appstyle.semiBoldText
                .copyWith(color: Colors.amberAccent, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
