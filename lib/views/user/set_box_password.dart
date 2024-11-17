import 'dart:async';

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetBoxPasswordPage extends StatefulWidget {
  const SetBoxPasswordPage({super.key});

  @override
  State<SetBoxPasswordPage> createState() => _SetBoxPasswordPageState();
}

class _SetBoxPasswordPageState extends State<SetBoxPasswordPage> {
  var pwController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Set Box Password",
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
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(22),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: TextFormField(
                    controller: pwController,
                    maxLines: 1,
                    style: TextStyle(color: Colors.amber, fontSize: 16),
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      label: Text(
                        "Box Password",
                        style: TextStyle(color: Colors.amber),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      filled: true,
                      fillColor: Appstyle.appBackGround,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 8) {
                        return "Password must be of 8 digit";
                      } else
                        return null;
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var setPwResult = await apiValues.setBoxPassword(
                        SharedPrefHelper.getBoxId(), pwController.text);
                    if (setPwResult['message'] ==
                        "User password set successfully") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(setPwResult['message']),
                        backgroundColor: Colors.green,
                      ));
                      Timer(Duration(seconds: 2), () {
                        Get.back();
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(252, 159, 66, 176),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
