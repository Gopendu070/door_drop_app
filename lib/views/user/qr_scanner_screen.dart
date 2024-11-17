import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:door_drop/views/partner/send_delivery_confirmation_page.dart';
import 'package:door_drop/views/user/qr_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String barcodeResult = 'Scan the QR code';
  String qrDetails = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan QR",
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
      backgroundColor: Appstyle.appBackGround,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(15),
            height: 300,
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MobileScanner(
                  onDetect: (barcode) {
                    final codes = barcode.barcodes;
                    final code = codes.elementAt(0);
                    qrDetails = code.rawValue!;
                    setState(() {
                      barcodeResult = 'Barcode found!';
                    });
                    if (qrDetails != '') {
                      if (SharedPrefHelper.getIsPartner()) {
                        Get.to(SendDeliveryConfirmationPage(data: qrDetails));
                      } else {
                        Get.to(QrDetailsPage(data: qrDetails));
                      }
                      ;
                    }
                  },
                ),
              ),
              // Overlay with rounded rectangle border
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                child: Center(
                  child: CustomPaint(
                    size: const Size(300, 300),
                    painter: CornerBorderPainter(),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(barcodeResult,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple)),
          ),
          Spacer(),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class CornerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded corners

    final double cornerLength = 30.0; // Length of the corner borders
    final double radius = 10.0; // For adjusting curve

    // Top-left corner
    canvas.drawLine(
        Offset(0, radius), Offset(0, cornerLength), paint); // Vertical line
    canvas.drawLine(
        Offset(radius, 0), Offset(cornerLength, 0), paint); // Horizontal line

    // Top-right corner
    canvas.drawLine(
        Offset(size.width, radius), Offset(size.width, cornerLength), paint);
    canvas.drawLine(Offset(size.width - cornerLength, 0),
        Offset(size.width - radius, 0), paint);

    // Bottom-left corner
    canvas.drawLine(Offset(0, size.height - radius),
        Offset(0, size.height - cornerLength), paint);
    canvas.drawLine(
        Offset(radius, size.height), Offset(cornerLength, size.height), paint);

    // Bottom-right corner
    canvas.drawLine(Offset(size.width, size.height - radius),
        Offset(size.width, size.height - cornerLength), paint);
    canvas.drawLine(Offset(size.width - cornerLength, size.height),
        Offset(size.width - radius, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
