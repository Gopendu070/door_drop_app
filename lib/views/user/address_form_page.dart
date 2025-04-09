import 'dart:async';

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddressFormPage extends StatefulWidget {
  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  String formatedAddress() {
    var houseNo = houseNoController.text;
    var street = streetController.text;
    var landmark = landmarkController.text;
    var pin = pinController.text;
    var dist = districtController.text;
    var state = stateController.text;

    var address =
        "$houseNo, $street, Landmark: $landmark, PIN: $pin, District: $dist, State: $state";
    return address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Address",
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name
                    Text(
                      "Name: Gopendu", //Todo
                      style: Appstyle.boldText
                          .copyWith(color: Colors.amber, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // House No Field
                    buildTextField(
                      "House No",
                      houseNoController,
                      validator: (value) => value == null || value.isEmpty
                          ? "House No cannot be empty"
                          : null,
                    ),
                    SizedBox(height: 16),

                    // Street Field
                    buildTextField(
                      "Street",
                      streetController,
                      validator: (value) => value == null || value.isEmpty
                          ? "Street cannot be empty"
                          : null,
                    ),
                    SizedBox(height: 16),

                    // Landmark Field
                    buildTextField(
                      "Landmark",
                      landmarkController,
                    ),
                    SizedBox(height: 16),

                    // PIN Field
                    buildTextField(
                      "PIN",
                      pinController,
                      validator: (value) => value == null || value.isEmpty
                          ? "PIN cannot be empty"
                          : (value.length != 6
                              ? "Enter a valid 6-digit PIN"
                              : null),
                    ),
                    SizedBox(height: 16),

                    // District Field
                    buildTextField(
                      "District",
                      districtController,
                      validator: (value) => value == null || value.isEmpty
                          ? "District cannot be empty"
                          : null,
                    ),
                    SizedBox(height: 16),

                    // State Field
                    buildTextField(
                      "State",
                      stateController,
                      validator: (value) => value == null || value.isEmpty
                          ? "State cannot be empty"
                          : null,
                    ),
                    SizedBox(height: 25),

                    // Save Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Action if all fields are valid

                            print(formatedAddress());
                            var addressUpdateRes = await apiValues
                                .updateAddress(formatedAddress());
                            // SharedPrefHelper.setAddress(formatedAddress());
                            if (addressUpdateRes['success']) {
                              SharedPrefHelper.setAddress(
                                  addressUpdateRes['address']);
                              Fluttertoast.showToast(
                                  msg: addressUpdateRes['message'],
                                  backgroundColor: Colors.green);
                              Timer(Duration(seconds: 1), () {
                                Get.back();
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: addressUpdateRes['message'],
                                  backgroundColor: Colors.red);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(252, 159, 66, 176),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 32),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Appstyle.appBackGround);
  }

  Widget buildTextField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    TextAlign textAlign = TextAlign.start,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(color: Colors.amber, fontSize: 16),
      cursorColor: Colors.amber,
      decoration: InputDecoration(
        label: Text(
          hint,
          style: TextStyle(color: Colors.amber),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
      validator: validator,
    );
  }
}
