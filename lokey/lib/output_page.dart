import 'package:flutter/material.dart';
import 'package:lokey/widget/banner_widget.dart';
import 'package:lokey/widget/half_wheel.dart';

class OutputPage extends StatelessWidget {
  const OutputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Result',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    width: 200,
                    height: 100,
                    child: CustomPaint(
                      painter: HalfCirclePainter(),
                    ),
                  ),
                ),
                const Text(
                  'You have\n\$5,500',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(50))
              ],
            ),
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}
