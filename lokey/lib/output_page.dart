import 'package:flutter/material.dart';
import 'package:lokey/widget/half_wheel.dart';

class OutputPage extends StatelessWidget {
  const OutputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Lokey Emergency Fund Predictor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Output Page',
              style: TextStyle(fontSize: 24),
            ),
            Container(
              width: 200,
              height: 100,
              child: CustomPaint(
                painter: HalfCirclePainter(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
