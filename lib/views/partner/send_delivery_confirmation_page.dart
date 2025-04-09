import 'package:door_drop/app_style/AppStyle.dart';
import 'package:door_drop/services/sharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendDeliveryConfirmationPage extends StatelessWidget {
  final String data;
  const SendDeliveryConfirmationPage({super.key, required this.data});
  String findUserEmail(String input) {
    // Define a regular expression pattern for matching email IDs
    final RegExp emailRegex = RegExp(
      r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
    );

    // Try to find the first match of the pattern in the input string
    final Match? match = emailRegex.firstMatch(input);

    // If a match is found, return the email ID; otherwise, return a message
    if (match != null) {
      return match.group(0) ?? ''; // Return the matched email or empty string
    } else {
      return '--------';
    }
  }

  String extractBoxId(String input) {
    // Regular expression to match a substring starting with "~#" and ending with "#~"
    final regex = RegExp(r'~#(.*?)#~');
    final match = regex.firstMatch(input);

    // Return the extracted string if found, otherwise return an empty string
    return match != null ? match.group(1) ?? '' : '';
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> sendEmail({
    required String recipient,
    required String subject,
    required String body,
  }) async {
    final Uri emailUri = Uri(
        scheme: 'mailto',
        path: recipient,
        query: encodeQueryParameters(<String, String>{
          'subject': subject,
          'body': body,
        }));

    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.appBackGround,
      appBar: AppBar(
        title: Text(
          "Requetst Delivery",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 340,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Colors.white12,
                    const Color.fromARGB(45, 0, 0, 0)
                  ])),
              padding: EdgeInsets.all(12),
              child: Text(
                data,
                textAlign: TextAlign.justify,
                style: Appstyle.semiBoldText
                    .copyWith(color: Colors.amberAccent, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  var boxId = extractBoxId(data);
                  var partnerEmail = SharedPrefHelper.getPartnerEmail();

                  var recipient = findUserEmail(data);
                  var confirmationLink =
                      'https://doordrop365.netlify.app/pin/$boxId/$recipient/$partnerEmail';
                  var body = data +
                      "\n\nClick the link below to confirm your delivery: \n$confirmationLink";
                  await sendEmail(
                      recipient: recipient,
                      subject: "Confirm your delivery",
                      body: body);
                },
                child: Text("Request Delivery"))
          ],
        ),
      ),
    );
  }
}
