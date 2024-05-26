import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BannerBuild(
          color: Colors.blue,
          title: 'Singlife Savvy Invest II',
          imagePath: 'assets/banner1.jpg',
        ),
        BannerBuild(
          color: Colors.green,
          title: 'GREAT SupremeHealth Enhanced with GREAT TotalCare',
          imagePath: 'assets/banner2.jpg',
        ),
        BannerBuild(
          color: Colors.orange,
          title: 'PRUSelect Vantage Fund',
          imagePath: 'assets/banner3.jpg',
        ),
      ],
    );
  }
}

class BannerBuild extends StatelessWidget {
  final Color color;
  final String title;
  final String imagePath;

  const BannerBuild(
      {Key? key,
      required this.color,
      required this.title,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
