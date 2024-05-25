import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              'Input Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: const Text('Go to output page'),
              onPressed: () {
                // Navigate to the About Page
                Navigator.pushNamed(context, '/output');
              },
            )
          ],
        ),
      ),
    );
  }
}
