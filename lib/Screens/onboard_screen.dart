import 'package:chatapp/Screens/splash_screen.dart';
import 'package:chatapp/Screens/onboard_screen2.dart';
import 'package:chatapp/constants/colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset('assets/images/ellipse.png'),
                    ),
                    Positioned(
                      child: Image.asset('assets/images/onboard_img.png'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 100,
              width: 300,
              child: Center(
                child: Text(
                  "Track your Comfort Food here",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 33,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                "Here You Can find a chef or dish for every taste and color. Enjoy!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: 230,
              height: 70,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      primaryColor), // Set your desired pink color here
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Set border radius to zero for no round corners
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnboardScreen2()),
                  );
                },
                child: Center(
                    child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
