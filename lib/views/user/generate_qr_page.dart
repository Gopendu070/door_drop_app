import 'dart:async';

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/controllers/order_controller.dart';
import 'package:door_drop/services/apiValues.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/user/qr_code_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class GenerateQRFormPage extends StatefulWidget {
  @override
  _GenerateQRFormPageState createState() => _GenerateQRFormPageState();
}

class _GenerateQRFormPageState extends State<GenerateQRFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields
  final TextEditingController nameController =
      TextEditingController(text: SharedPrefHelper.getName());
  final TextEditingController emailController =
      TextEditingController(text: SharedPrefHelper.getEmail());
  final TextEditingController phoneController =
      TextEditingController(text: SharedPrefHelper.getPhone());
  final TextEditingController orderIdController = TextEditingController();
  int qty = 1;
  final TextEditingController totalAmountController = TextEditingController();
  var orderController = Get.put(OrderController());
  var isLoading = false;
  String formatedData() {
    var name = nameController.text;
    var email = emailController.text;
    var phone = phoneController.text;
    var orderId = orderIdController.text;
    var boxId = "~#" + SharedPrefHelper.getBoxId() + "#~";
    var address = SharedPrefHelper.getAddress();
    var amount = totalAmountController.text;
    var quantity = qty.toString();
    var data = """
        Name: ${name.trim()},
        Email: ${email.trim()},
        Phone: ${phone},
        BoxID; $boxId,
        Address: $address,

        Order Details:-
        Order ID: ${orderId},
        Quantity: ${quantity},
        Total: Rs. ${amount}""";
    return data;
  }

  String extractBoxId(String input) {
    // Regular expression to match a substring starting with "~#" and ending with "#~"
    final regex = RegExp(r'~#(.*?)#~');
    final match = regex.firstMatch(input);

    // Return the extracted string if found, otherwise return an empty string
    return match != null ? match.group(1) ?? '' : '';
  }

  void getOrderHistoryList() async {
    var userInfoResult = await apiValues.getUserInfo();
    print(userInfoResult['user']);
    List<dynamic> list = userInfoResult['user']['orderHistory'];
    orderController.updateOrderHistoryList(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Generate QR",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Field
                  SizedBox(height: 15),
                  buildTextField(
                    "Name",
                    nameController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Name cannot be empty"
                        : null,
                  ),
                  SizedBox(height: 16),

                  // Email Field

                  buildTextField(
                    "Email",
                    emailController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Email cannot be empty"
                        : (!value.contains('@') ? "Enter a valid email" : null),
                  ),
                  SizedBox(height: 16),

                  // Phone Field

                  buildTextField(
                    "Phone",
                    phoneController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Phone number cannot be empty"
                        : (value.length != 10
                            ? "Enter a valid phone number"
                            : null),
                  ),
                  SizedBox(height: 16),
                  Divider(
                    color: Colors.purpleAccent,
                    thickness: 2,
                  ),
                  SizedBox(height: 16),

                  buildTextField("Order ID", orderIdController,
                      validator: (value) => value == null || value.isEmpty
                          ? "Order ID number cannot be empty"
                          : null),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      Text(
                        "Quantity:",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      buildQuantityButton(Icons.remove, () {
                        if (qty > 1) {
                          setState(() {
                            qty--;
                          });
                        }
                      }),
                      Text(
                        qty.toString(),
                        style: TextStyle(color: Colors.amber, fontSize: 16),
                      ),
                      buildQuantityButton(Icons.add, () {
                        setState(() {
                          if (qty <= 20) {
                            qty++;
                          } else if (qty > 20) {
                            Fluttertoast.showToast(
                                msg: "Reached maximum limit");
                          }
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Total Amount
                  buildTextField("Total amount", totalAmountController,
                      validator: (value) => value == null || value.isEmpty
                          ? "Amount cannot be empty"
                          : null),
                  SizedBox(
                    height: 25,
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  // Generate Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (SharedPrefHelper.getAddress() == "") {
                            Fluttertoast.showToast(
                                msg: "Please add  a address first");
                          } else {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            var addOrderRes = await apiValues.addOrder(
                                orderIdController.text,
                                qty.toString(),
                                totalAmountController.text);
                            if (addOrderRes['success']) {
                              getOrderHistoryList();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("QR Code Generated"),
                                backgroundColor: Colors.green,
                              ));

                              Timer(Duration(seconds: 1), () {
                                Get.to(QrCodePage(qrData: formatedData()));
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Something went wrong"),
                                backgroundColor: Colors.red,
                              ));
                            }
                            setState(() {
                              isLoading = !isLoading;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(252, 159, 66, 176),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                      ),
                      child: isLoading
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator()),
                            )
                          : Text(
                              "Generate",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Appstyle.appBackGround,
    );
  }

  Widget buildTextField(
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    TextAlign textAlign = TextAlign.start,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          color: Colors.amber, fontSize: 16, fontWeight: FontWeight.w500),
      cursorColor: Colors.amber,
      decoration: InputDecoration(
        prefixText: hint == "Total amount" ? "Rs. " : null,
        prefixStyle: TextStyle(color: Colors.amber),
        label: Text(
          hint,
          style: TextStyle(color: Colors.amber),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        filled: true,
        fillColor: Appstyle.appBackGround,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(color: Colors.purpleAccent),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(color: Colors.purpleAccent),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purpleAccent),
        ),
      ),
      validator: validator,
    );
  }

  Widget buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 44,
      height: 44,
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(251, 159, 69, 175),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
