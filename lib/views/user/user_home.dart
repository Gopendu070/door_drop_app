// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/other/helper.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool isBoxLocked = !true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(175, 54, 54, 54),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0, // Height when expanded
            pinned: false, // Keeps the app bar visible when collapsed
            floating: false, // Prevents app bar from appearing mid-scroll
            snap: false, // Works with floating, enables snapping behavior
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
              "asset/baba.jpg",
              fit: BoxFit.cover,
            )),
          ),
          SliverAppBar(
            expandedHeight: 40,
            // collapsedHeight: 65,
            toolbarHeight: 45,
            pinned: true,
            snap: false,
            flexibleSpace: GestureDetector(
              onTap: () {
                setState(() {
                  isBoxLocked = !isBoxLocked;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: isBoxLocked
                        ? LinearGradient(
                            colors: [
                                const Color.fromARGB(214, 28, 28, 28),
                                Color.fromARGB(170, 87, 231, 162),
                                Color.fromARGB(170, 87, 231, 162),
                                Color.fromARGB(170, 87, 231, 162),
                                Color.fromARGB(214, 28, 28, 28),
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
                          func: () {},
                        ),
                        QrCardWidget(
                          icon: Icons.qr_code,
                          label: "Generate QR",
                          func: () {},
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
