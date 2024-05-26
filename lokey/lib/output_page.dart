import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lokey/model/output_arguments.dart';
import 'package:lokey/widget/banner_widget.dart';
import 'package:lokey/widget/half_wheel.dart';
import 'dart:convert';

class OutputPage extends StatefulWidget {
  final OutputArguments arguments;

  const OutputPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  bool showRecommend = false;

  @override
  Widget build(BuildContext context) {
    // Access emergency fund value
    int actualEmergencyFunds = widget.arguments.emergencyFund;

    // Access API response
    // Access API response
    Map<String, dynamic> jsonResponse =
        jsonDecode(widget.arguments.apiResponse);
    double predictedEmergencyFundsDouble =
        jsonResponse["Predicted Recommended Emergency Fund"];

// Convert the double value to an integer
    int predictedEmergencyFunds = predictedEmergencyFundsDouble.round().toInt();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/image/lokey_image.jpg', width: 30, height: 30),
            Container(
              padding: const EdgeInsets.all(10),
            ),
            const Text(
              'Result',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: SizedBox(
                    width: 200,
                    height: 100,
                    child: CustomPaint(
                      painter: HalfCirclePainter(
                          actualEmergencyFunds, predictedEmergencyFunds),
                    ),
                  ),
                ),
                Text(
                  'You have\n\$${actualEmergencyFunds.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(30))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !showRecommend,
              child: ElevatedButton(
                child: const Text(
                  'Show financial path',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showRecommend = true;
                  });
                },
              ),
            ),
            showRecommend ? BannerWidget() : Container(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text(
                'Resubmit again',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                // Navigate to the input Page
                Navigator.pushNamed(context, '/input');
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
