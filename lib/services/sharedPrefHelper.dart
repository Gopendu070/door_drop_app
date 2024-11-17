import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences _prefs;

  static Future<void> initPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> clearPref() async {
    await _prefs.clear();
  }

  static bool getIsLoggedIn() {
    return _prefs.getBool("isLoggedIn") ?? false;
  }

  static void setIsLoggedInTrue() {
    _prefs.setBool("isLoggedIn", true);
  }

  static void setIsLoggedInFlase() {
    _prefs.setBool("isLoggedIn", false);
  }

  static bool getIsPartner() {
    return _prefs.getBool("isPartner") ?? false;
  }

  static void setIsPartnerTrue() {
    _prefs.setBool("isPartner", true);
  }

  static void setIsPartnerFalse() {
    _prefs.setBool("isPartner", false);
  }

  static String getName() {
    return _prefs.getString("name") ?? "";
  }

  static String getPartnerName() {
    return _prefs.getString("pname") ?? "";
  }

  static String getPartnerPassword() {
    return _prefs.getString("ppassword") ?? "";
  }

  static String getId() {
    return _prefs.getString("id") ?? "";
  }

  static String getBoxId() {
    return _prefs.getString("boxId") ?? "";
  }

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static String getPartnerPhone() {
    return _prefs.getString("pphone") ?? "";
  }

  static String getAddress() {
    return _prefs.getString("address") ?? "";
  }

  static String getEmail() {
    return _prefs.getString("email") ?? "";
  }

  static String getPartnerEmail() {
    return _prefs.getString("pemail") ?? "";
  }

  static void setName(String name) {
    _prefs.setString("name", name);
  }

  static void setPartnerName(String name) {
    _prefs.setString("pname", name);
  }

  static void setPartnerPassword(String pw) {
    _prefs.setString("ppassword", pw);
  }

  static void setId(String id) {
    _prefs.setString("id", id);
  }

  static void setBoxId(String id) {
    _prefs.setString("boxId", id);
  }

  static void setPhone(String phone) {
    _prefs.setString("phone", phone);
  }

  static void setPartnerPhone(String phone) {
    _prefs.setString("pphone", phone);
  }

  static void setAddress(String address) {
    _prefs.setString("address", address);
  }

  static void setEmail(String email) {
    _prefs.setString("email", email);
  }

  static void setPartnerEmail(String email) {
    _prefs.setString("pemail", email);
  }
}
