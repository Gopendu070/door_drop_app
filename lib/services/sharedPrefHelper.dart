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

  static String getUserToken() {
    return _prefs.getString("token") ?? "";
  }

  static void setUserToken(String token) {
    _prefs.setString("token", token);
  }

  static String getName() {
    return _prefs.getString("name") ?? "";
  }

  static void setName(String name) {
    _prefs.setString("name", name);
  }

  static String getId() {
    return _prefs.getString("id") ?? "";
  }

  static void setId(String id) {
    _prefs.setString("id", id);
  }

  static String getBoxId() {
    return _prefs.getString("boxId") ?? "";
  }

  static void setBoxId(String id) {
    _prefs.setString("boxId", id);
  }

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static void setPhone(String phone) {
    _prefs.setString("phone", phone);
  }

  static String getAddress() {
    return _prefs.getString("address") ?? "";
  }

  static void setAddress(String address) {
    _prefs.setString("address", address);
  }

  static String getEmail() {
    return _prefs.getString("email") ?? "";
  }

  static void setEmail(String email) {
    _prefs.setString("email", email);
  }

  ////////////////////////////////////Partner/////////////////////////////////////////////////
  ///
  ///
  static String getPartnerId() {
    return _prefs.getString("pid") ?? "";
  }

  static void setPartnerId(String id) {
    _prefs.setString("pid", id);
  }

  static String getPartnerToken() {
    return _prefs.getString("ptoken") ?? "";
  }

  static void setPartnerToken(String token) {
    _prefs.setString("ptoken", token);
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

  static String getPartnerName() {
    return _prefs.getString("pname") ?? "";
  }

  static void setPartnerName(String name) {
    _prefs.setString("pname", name);
  }

  static String getPartnerPassword() {
    return _prefs.getString("ppassword") ?? "";
  }

  static void setPartnerPassword(String pw) {
    _prefs.setString("ppassword", pw);
  }

  static String getPartnerEmail() {
    return _prefs.getString("pemail") ?? "";
  }

  static void setPartnerEmail(String email) {
    _prefs.setString("pemail", email);
  }

  static String getPartnerPhone() {
    return _prefs.getString("pphone") ?? "";
  }

  static void setPartnerPhone(String phone) {
    _prefs.setString("pphone", phone);
  }
}
