import 'package:flutter/material.dart';
import 'package:lokey/widget/user_form.dart';

/// A page for user input.
class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Input',
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            const Text(
              'Emergency Fund Predictor',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            UserForm(),
          ],
        ),
      ),
    );
  }
}
