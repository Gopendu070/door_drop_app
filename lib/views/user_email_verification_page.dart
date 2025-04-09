import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/user/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserEmailVerificationPage extends StatefulWidget {
  const UserEmailVerificationPage({
    super.key,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
  final String name;
  final String email;
  final String password;
  final String phone;

  @override
  State<UserEmailVerificationPage> createState() =>
      _UserEmailVerificationPageState();
}

class _UserEmailVerificationPageState extends State<UserEmailVerificationPage> {
  var isLoading = false;
  var _otpController = TextEditingController();
  void verifyEmail(String otp) async {
    setState(() {
      isLoading = true;
    });
    var otpResult = await apiValues.verfyUserByOTP(widget.email, otp);
    print(otpResult);
    if (otpResult['success']) {
      print(otpResult);
      //todo
      Fluttertoast.showToast(msg: "Email verified successfully");
      Get.offAll(UserLoginPage());
    } else {
      Fluttertoast.showToast(msg: otpResult['message']);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        title: Text(
          "OTP Verification",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 239, 206, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 239, 206, 245),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3 - 40,
            margin: EdgeInsets.all(14),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 112, 67, 190),
                )),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "We've sent you an OTP",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 112, 67, 190),
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                  child: TextFormField(
                    controller: _otpController,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.34),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      var otp = _otpController.text;
                      if (otp.length < 6) {
                        Fluttertoast.showToast(
                            msg: "OTP must be 6 digit",
                            toastLength: Toast.LENGTH_SHORT);
                      } else
                        verifyEmail(otp);
                    },
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator()),
                          )
                        : Text("Verify OTP")),
                // SizedBox(height: 30)
              ],
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
