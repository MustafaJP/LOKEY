import 'package:flutter/material.dart';

class OutputPage extends StatelessWidget {
  const OutputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Output Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: const Text('Go to Recommendation page'),
              onPressed: () {
                // Navigate to the About Page
                Navigator.pushNamed(context, '/recommendation');
              },
            )
          ],
        ),
      ),
    );
  }
}
