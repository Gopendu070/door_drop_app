// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/other/helper.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/about_us_page.dart';
import 'package:door_drop/views/app_landing_page.dart';
import 'package:door_drop/views/user/address_form_page.dart';
import 'package:door_drop/views/user/generate_qr_page.dart';
import 'package:door_drop/views/user/qr_scanner_screen.dart';
import 'package:door_drop/views/user/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PartnerHome extends StatefulWidget {
  const PartnerHome({super.key});

  @override
  State<PartnerHome> createState() => _PartnerHomeState();
}

final name = SharedPrefHelper.getPartnerName();
final email = SharedPrefHelper.getPartnerEmail();
final phone = SharedPrefHelper.getPartnerPhone();
final id = "110231019";

class _PartnerHomeState extends State<PartnerHome> {
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
                Navigator.of(context).pop();
                SharedPrefHelper.setIsPartnerFalse();
                SharedPrefHelper.setIsLoggedInFlase();

                Get.offAll(AppLandingPage());
                print('User logged out');
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

  bool isBoxLocked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(175, 54, 54, 54),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 83, 45, 149),
        onPressed: () {
          Get.to(QrScannerScreen());
        },
        child: Icon(
          Icons.qr_code_scanner,
          size: 35,
          color: Colors.amber,
        ),
      ),
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
              SharedPrefHelper.getPartnerName(),
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
            // Spacer(),
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
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: null,
            expandedHeight: 300.0, // Height when expanded
            pinned: false, // Keeps the app bar visible when collapsed
            floating: false, // Prevents app bar from appearing mid-scroll
            snap: false, // Works with floating, enables snapping behavior
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 330,
                  color: const Color.fromARGB(228, 0, 0, 0),
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'asset/deliver.jpg',
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          partnerDetailsText(
                            text1: "Name: ",
                            text2: name,
                          ),
                          partnerDetailsText(
                            text1: "Email: ",
                            text2: email,
                          ),
                          partnerDetailsText(
                            text1: "Mobile: ",
                            text2: phone,
                          ),
                          partnerDetailsText(
                            text1: "Partner ID: ",
                            text2: id,
                          ),
                        ],
                      ),
                    ),
                  )),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12),
                    child: Text(
                      "Deliveries",
                      style: Appstyle.boldText
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                  );
                } else {
                  var details = HelperClass.deliveryList[index];
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                              color: const Color.fromARGB(221, 255, 255, 255),
                            )))
                  ]);
                }
              },
              childCount: HelperClass.deliveryList.length - 1,
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

class partnerDetailsText extends StatelessWidget {
  final String text1;
  final String text2;
  const partnerDetailsText({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text1,
          style:
              Appstyle.semiBoldText.copyWith(color: Colors.amber, fontSize: 16),
        ),
        Text(
          text2,
          style: Appstyle.semiBoldText.copyWith(
              color: const Color.fromARGB(255, 226, 224, 204), fontSize: 16),
        )
      ],
    );
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
