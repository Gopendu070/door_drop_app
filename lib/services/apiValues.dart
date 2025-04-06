import 'dart:convert';

import 'package:http/http.dart' as http;

///// added to .gitignore

class Apivalues {
  Future<dynamic> userLogin(String email, String passWord) async {
    try {
      var userLoginApi = "https://doordropbackend.onrender.com/api/user/login";
      var data = {
        "email": email,
        "password": passWord,
      };

      var response = await http.post(Uri.parse(userLoginApi),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> userSignUp(
      String name, String email, String passWord, String phone) async {
    try {
      var userSignUpAPI =
          "https://doordropbackend.onrender.com/api/user/signup";
      var data = {
        "name": name,
        "email": email,
        "password": passWord,
        "phone": phone,
      };

      var response = await http.post(Uri.parse(userSignUpAPI),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> verfyUserByEmail(String email, String otp) async {
    try {
      var verifyEmailAPI =
          "https://doordropbackend.onrender.com/api/user/verifyotp";
      var data = {"email": email, "otp": otp};

      var response = await http.post(Uri.parse(verifyEmailAPI),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> setBoxPassword(String boxId, String password) async {
    try {
      var setBoxPwAPI =
          "https://doordropbackend.onrender.com/api/box/setpassword";
      var data = {"boxId": boxId, "password": password};

      var response = await http.post(Uri.parse(setBoxPwAPI),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> sendOtp(String email) async {
    try {
      var sendOtpAPI = "https://doordropbackend.onrender.com/api/user/sendotp";
      var data = {"email": email};

      var response = await http.post(Uri.parse(sendOtpAPI),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return null;
    }
  }
  /////////////////////////////////////////////////////////
}

var apiValues = Apivalues();
