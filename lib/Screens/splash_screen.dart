import 'dart:async';

import 'package:chatapp/Screens/onboard_screen.dart';
// import 'package:chatapp/constants/colors.dart'; // Fixed the import path typo
import 'package:chatapp/constants/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Using Timer instead of Timer.periodic for one-time navigation
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
  // print();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: Stack(
          children: [
            Center(
              child: Image.asset("assets/images/logo1.png"),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset("assets/images/logo2.png"),
            ),
          ],
        ),
      ),
    );
  }
}
