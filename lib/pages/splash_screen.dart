import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/pages/home_page/home_page.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          AppConstants.splashGifPath,
          fit: BoxFit.cover,
          width: 400, // Adjust the width and height as needed
          height: 400,
          repeat: true, // Set to true if you want the animation to loop
        ),
      ),
    );
  }
}