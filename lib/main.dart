import 'package:flutter/material.dart';
import 'package:phinconbootcamp/splashscreen.dart';

void main() {
  runApp(PhincontestApp());
}

class PhincontestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}