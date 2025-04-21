import 'package:door_drop/views/app_landing_page.dart';
import 'package:door_drop/views/partner/partner_home.dart';
import 'package:door_drop/views/user/user_home.dart';
import 'package:door_drop/views/user/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'services/sharedPrefHelper.dart';

void main() async {
  // Force Portrait Mode

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.initPref();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget checkRoute() {
    if (SharedPrefHelper.getIsPartner()) {
      if (SharedPrefHelper.getIsLoggedIn()) {
        return PartnerHome();
      } else {
        return AppLandingPage();
      }
    } else {
      if (SharedPrefHelper.getIsLoggedIn()) {
        return UserHome();
      } else {
        return AppLandingPage();
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: checkRoute(),
    );
  }
}
