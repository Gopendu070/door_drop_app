import 'package:dio/dio.dart';
import 'package:door_drop/services/dio_client.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/partner/partner_home.dart';

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

      // Success case
      if (response.statusCode == 200) {
        print("Login successful: ${response.data}");
        return response.data;
      } else {
        // Non-200 but still return the response
        print("Non-200 Response: ${response.statusCode} => ${response.data}");
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final errorData = e.response?.data;
        print("=====================================");
        print("Handled Error $statusCode: $errorData");
        return errorData; // ✅ Returning response even if it's an error
      } else {
        print("Network or unknown error: ${e.message}");
        return {
          'message': 'Network error',
          'success': false
        }; // Optional fallback
      }
    } catch (e) {
      print("Unexpected error: $e");
      return {'message': 'Unexpected error', 'success': false};
    }
  }

  Future<dynamic> updateAddress(String address) async {
    try {
      print("1");
      final dio = await DioClient.getInstance();
      print("2");
      final response = await dio.post('/user/updateaddress',
          data: {"address": address},
          options: Options(headers: {
            "Authorization": "Bearer ${SharedPrefHelper.getUserToken()}"
          }));
      print("3");
      print(response.statusCode);
      return response.data;
    } catch (e) {
      print(" $e");
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

  Future<dynamic> getUserInfo() async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.get('/user/getuserinfo',
          data: {"email": SharedPrefHelper.getEmail()});
      return response.data;
    } catch (e) {
      print(e);
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
      return response.data;
    } catch (e) {
      print("Verify OTP Error: $e");
      return null;
    }
  }

////////////////////////////////////////// BOX ///////////////////////////////////////////////////

  Future<dynamic> setBoxPassword(
    String password,
    String boxPin,
  ) async {
    try {
      final dio = await DioClient.getInstance();
      print(SharedPrefHelper.getUserToken());
      final response = await dio.post(
        '/box/setpassword',
        data: {
          "email": SharedPrefHelper.getEmail(),
          "password": password,
          "boxPin": boxPin,
        },
        options: Options(headers: {
          "Authorization": "Bearer ${SharedPrefHelper.getUserToken()}"
        }),
      );
      return response.data;
    } catch (e) {
      print("Set Box Password Error: $e");
      return null;
    }
  }

  Future<dynamic> toggleBoxLock() async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post('/box/openbox',
          options: Options(headers: {
            "Authorization": "Bearer ${SharedPrefHelper.getUserToken()}"
          }));
      return response.data;
    } catch (e) {
      print("Error: $e");
    }
  }

////////////////////////////////////////// ORDER ///////////////////////////////////////////////////
  Future<dynamic> deleteOrderByOrderId(String orderId) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post('/order/deleteorder',
          data: {"orderId": orderId, "boxId": SharedPrefHelper.getBoxId()},
          options: Options(headers: {
            "Authorization": "Bearer ${SharedPrefHelper.getUserToken()}"
          }));
      return response.data;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<dynamic> addOrder(
      String orderId, String quantity, String totalAmount) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post('/order/addorder',
          data: {
            "orderId": orderId,
            "quantity": quantity,
            "totalAmount": totalAmount
          },
          options: Options(headers: {
            "Authorization": "Bearer ${SharedPrefHelper.getUserToken()}"
          }));
      return response.data;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<dynamic> updateOrder(String orderId) async {
    try {
      final dio = await DioClient.getInstance();
      final response = await dio.post('/order/updateOrder',
          data: {
            "boxId": SharedPrefHelper.getBoxId(),
            "orderId": orderId,
            "status": "Completed"
          },
          options: Options(headers: {
            "Authorization": "Bearer ${SharedPrefHelper.getUserToken()}"
          }));
      return response.data;
    } catch (e) {
      print("Error: $e");
    }
  }
}

final apiValues = Apivalues();
