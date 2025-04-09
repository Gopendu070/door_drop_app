import 'dart:io';
import 'dart:typed_data';

import 'package:door_drop/app_style/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key, required this.qrData});
  final String qrData;

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  var isSaved = false;
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    Future<void> saveToExternalStorage(Uint8List imageBytes) async {
      try {
        // Define the custom folder path
        final customFolder =
            Directory('/storage/emulated/0/Download/door_drop_qrs');

        // Check if the directory exists, if not, create it
        if (!customFolder.existsSync()) {
          customFolder.createSync(recursive: true);
        }

        // Define the file path
        final filePath =
            '${customFolder.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png';

        // Write the file
        final file = File(filePath);
        await file.writeAsBytes(imageBytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Saved at: /storage/emulated/0/Download/door_drop_qrs'),
            backgroundColor: Colors.green,
          ),
        );
        isSaved = true;
        setState(() {});
      } catch (e) {
        print('Error saving file: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QR",
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
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isSaved)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    color: Colors.greenAccent,
                    size: 30,
                  ),
                  Text(
                    "  Saved successfully!",
                    style: Appstyle.semiBoldText
                        .copyWith(color: Colors.greenAccent),
                  ),
                ],
              ),
            SizedBox(height: 25),
            QrBuilder(widget.qrData),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var imageQr = await screenshotController
                    .captureFromWidget(QrBuilder(widget.qrData));
                print(imageQr.toString());
                await saveToExternalStorage(imageQr);
                // await _saveQRCodeToGallery(imageQr);
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(252, 159, 66, 176),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32),
              ),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<String> svaeImage(Uint8List imageQr) async {
//   var time = DateTime.now()
//       .toIso8601String()
//       .replaceAll(".", '-')
//       .replaceAll(":", "-");
//   var ssName = "QR_$time";
//   final result = await ImageGallerySaver.saveImage(imageQr, name: ssName);
//   return result['filePath'];
// }

Widget QrBuilder(String qrData) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 3),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)),
    child: QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 270,
    ),
  );
}
