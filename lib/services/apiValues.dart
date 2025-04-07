import 'package:dio/dio.dart';
import 'package:door_drop/services/dio_client.dart';

class Apivalues {
  ////////////////////////////////////  USER ///////////////////////////////////////////////////
  Future<dynamic> userLogin(String email, String passWord) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post(
        '/user/login',
        data: {
          "email": email,
          "password": passWord,
        },
      );
      return response.data;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  Future<dynamic> userSignUp(
      String name, String email, String passWord, String phone) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post(
        '/user/register',
        data: {
          "name": name,
          "email": email,
          "password": passWord,
          "phoneNumber": phone,
        },
      );
      return response.data;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  Future<dynamic> verfyUserByOTP(String email, String otp) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post(
        '/user/verifyotp',
        data: {
          "email": email,
          "otp": otp,
        },
      );
      print("Status code: ${response.statusCode}");
      return response.data;
    } catch (e) {
      print("Verify OTP Error: $e");
      return null;
    }
  }

  /////////////////////////////////////////// DELIVERY BOY ////////////////////////////////////////
  Future<dynamic> deliveryBoyLogin(String email, String passWord) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post(
        '/deliveryboy/login',
        data: {
          "email": email,
          "password": passWord,
        },
      );
      return response.data;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  Future<dynamic> deliveryBoySignUp(
      String name, String email, String passWord, String phone) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post(
        '/deliveryboy/register',
        data: {
          "name": name,
          "email": email,
          "password": passWord,
          "phoneNumber": phone,
        },
      );
      return response.data;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  Future<dynamic> verfyDeliveryBoyEmailByOTP(String email, String otp) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post(
        '/deliveryboy/verifyotp',
        data: {
          "email": email,
          "otp": otp,
        },
      );
      print("Status code: ${response.statusCode}");
      print(response.data);
      return response.data;
    } catch (e) {
      print("Verify OTP Error: $e");
      return null;
    }
  }

  Future<dynamic> setBoxPassword(String boxId, String password) async {
    try {
      final dio = await DioClient.getInstance();
      // final customDio = dio.copyWith(
      //   baseUrl: "https://doordropbackend.onrender.com/api",
      // );
      final response = await dio.post(
        //recheck url
        '/box/setpassword',
        data: {
          "boxId": boxId,
          "password": password,
        },
      );
      return response.data;
    } catch (e) {
      print("Set Box Password Error: $e");
      return null;
    }
  }
}

final apiValues = Apivalues();
