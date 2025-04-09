// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/other/helper.dart';
import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/about_us_page.dart';
import 'package:door_drop/views/app_landing_page.dart';
import 'package:door_drop/views/user/address_form_page.dart';
import 'package:door_drop/views/user/generate_qr_page.dart';
import 'package:door_drop/views/user/qr_scanner_screen.dart';
import 'package:door_drop/views/user/set_box_password.dart';
import 'package:door_drop/views/user/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Are you sure you want to logout?',
            style: Appstyle.semiBoldText,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                var partnerEmail = SharedPrefHelper.getPartnerEmail();
                var partnerPass = SharedPrefHelper.getPartnerPassword();
                var partnerName = SharedPrefHelper.getPartnerName();
                var partnerPhone = SharedPrefHelper.getPartnerPhone();
                var address = SharedPrefHelper.getAddress();
                var boxId = SharedPrefHelper.getBoxId();
                Navigator.of(context).pop();
                SharedPrefHelper.clearPref();
                //set the partner's shared pref
                SharedPrefHelper.setPartnerEmail(partnerEmail);
                SharedPrefHelper.setPartnerPassword(partnerPass);
                SharedPrefHelper.setPartnerName(partnerName);
                SharedPrefHelper.setPartnerPhone(partnerPhone);
                //set user address and boxId
                SharedPrefHelper.setAddress(address);
                SharedPrefHelper.setBoxId(boxId);
                Timer(Duration(seconds: 1), () {
                  Get.offAll(AppLandingPage());
                  print('User logged out');
                });
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isBoxLocked = SharedPrefHelper.getBoxIsLocked();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(175, 54, 54, 54),
      endDrawer: Container(
        width: 200,
        color: Appstyle.appBackGround.withOpacity(0.95),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(color: Colors.blue)),
              child: Lottie.asset('asset/user.json', fit: BoxFit.cover),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              SharedPrefHelper.getName(),
              style: Appstyle.boldText.copyWith(color: Colors.amber),
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              color: Colors.amber,
            ),
            SizedBox(
              height: 25,
            ),
            DrawerClipWidget(
              label: "Set Address",
              func: () {
                Get.to(AddressFormPage());
              },
            ),
            SizedBox(
              height: 25,
            ),
            DrawerClipWidget(
              label: "Set Box Password",
              func: () {
                if (SharedPrefHelper.getBoxId().isNotEmpty)
                  Get.to(SetBoxPasswordPage());
                else {
                  Get.snackbar("You don't have a Smart Box yet",
                      "Please contact our team.",
                      colorText: Colors.white,
                      backgroundColor: const Color.fromARGB(206, 255, 82, 82));
                }
              },
            ),
            SizedBox(
              height: 25,
            ),
            DrawerClipWidget(
              label: "About Us",
              func: () {
                Get.to(AboutUsPage());
              },
            ),
            SizedBox(
              height: 25,
            ),
            DrawerClipWidget(
              label: "Logout",
              func: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320.0, // Height when expanded
            pinned: false, // Keeps the app bar visible when collapsed
            floating: false, // Prevents app bar from appearing mid-scroll
            snap: false, // Works with floating, enables snapping behavior
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      const Color.fromARGB(255, 90, 88, 88),
                      const Color.fromARGB(225, 0, 0, 0),
                      Colors.black
                    ])),
                child: Center(
                  child: Image.asset(
                    "asset/box.png",
                    height: 280,
                  ),
                ),
              ),
              Positioned(
                top: 25,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white30),
                  child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.amber,
                      )),
                ),
              )
            ])),
          ),
          SliverAppBar(
            expandedHeight: 40,
            // collapsedHeight: 65,
            toolbarHeight: 45,
            pinned: true,
            snap: false,
            flexibleSpace: GestureDetector(
              onTap: () async {
                if (SharedPrefHelper.getBoxId().isNotEmpty) {
                  var boxLockResult = await apiValues.toggleBoxLock();
                  if (boxLockResult['success']) {
                    setState(() {
                      isBoxLocked = !isBoxLocked;
                      SharedPrefHelper.setBoxIsLockedd(isBoxLocked);
                    });
                    Fluttertoast.showToast(msg: boxLockResult['message']);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Some error occured", backgroundColor: Colors.red);
                  }
                } else {
                  Get.snackbar("You don't have a Drop Box yet",
                      "Please contact our team.",
                      colorText: Colors.white,
                      backgroundColor: const Color.fromARGB(206, 255, 82, 82));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: isBoxLocked
                        ? LinearGradient(
                            colors: [
                                const Color.fromARGB(214, 28, 28, 28),
                                Color.fromARGB(170, 87, 231, 162),
                                Color.fromARGB(170, 87, 231, 162),
                                Color.fromARGB(196, 61, 165, 115),
                                Color.fromARGB(235, 28, 28, 28),
                              ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)
                        : LinearGradient(
                            colors: [
                                const Color.fromARGB(214, 28, 28, 28),
                                Color.fromARGB(224, 246, 67, 67),
                                Color.fromARGB(224, 246, 67, 67),
                                Color.fromARGB(224, 246, 67, 67),
                                Color.fromARGB(214, 28, 28, 28),
                              ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isBoxLocked ? Icons.lock : Icons.lock_open,
                      size: 25,
                    ),
                    Text(
                      isBoxLocked ? 'Box Locked' : 'Box Unlocked',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Container(
                    height: 120,
                    color: Colors.black87,
                    child: Row(
                      children: [
                        QrCardWidget(
                          icon: Icons.qr_code_scanner,
                          label: "Scan QR",
                          func: () {
                            Get.to(QrScannerScreen());
                          },
                        ),
                        QrCardWidget(
                          icon: Icons.qr_code,
                          label: "Generate QR",
                          func: () {
                            if (SharedPrefHelper.getBoxId().isNotEmpty)
                              Get.to(GenerateQRFormPage());
                            else
                              Get.snackbar("You don't have a Smart Box yet",
                                  "Please contact our team.",
                                  colorText: Colors.white,
                                  backgroundColor:
                                      const Color.fromARGB(206, 255, 82, 82));
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  var details = HelperClass.deliveryList[index - 1];
                  return Stack(children: [
                    Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color.fromARGB(45, 194, 192, 192),
                                  const Color.fromARGB(226, 0, 0, 0),
                                  // const Color.fromARGB(183, 0, 0, 0),
                                  // const Color.fromARGB(231, 0, 0, 0),
                                ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("Order ID: ",
                                    style: Appstyle.whiteText
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  details['orderId'].toString(),
                                  style: Appstyle.whiteText,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Delivery: ",
                                    style: Appstyle.whiteText
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(
                                  details['delivery'].toString(),
                                  style: Appstyle.whiteText,
                                ),
                              ],
                            ),
                            Text(
                              details['status'].toString(),
                              style: Appstyle.whiteText.copyWith(
                                  color:
                                      statusColor(details['status'].toString()),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ],
                        )),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                HelperClass.deliveryList.removeAt(index - 1);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: const Color.fromARGB(221, 255, 255, 255),
                            )))
                  ]);
                }
              },
              childCount: HelperClass.deliveryList.length + 1,
            ),
          ),
        ],
      ),
    );
  }

  Color statusColor(String sts) {
    if (sts == 'Delivered')
      return Colors.greenAccent;
    else if (sts == 'Pending')
      return Colors.orangeAccent;
    else
      return Colors.redAccent;
  }
}

class DrawerClipWidget extends StatelessWidget {
  const DrawerClipWidget({
    super.key,
    required this.label,
    required this.func,
  });
  final String label;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: 177,
        decoration: BoxDecoration(
            border: Border.all(
                color: label == 'Logout' ? Colors.redAccent : Colors.amber),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            label,
            style: Appstyle.semiBoldText.copyWith(
                color: label == 'Logout' ? Colors.redAccent : Colors.amber),
          ),
        ),
      ),
    );
  }
}

class QrCardWidget extends StatelessWidget {
  const QrCardWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.func,
  });
  final String label;
  final IconData icon;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.amberAccent,
                  size: 50,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  label,
                  style: TextStyle(color: Colors.amberAccent),
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amberAccent)),
          ),
        ),
      ),
    );
  }
}
