import 'package:chatapp/Screens/login_screen.dart';
import 'package:chatapp/constants/colors.dart';
import 'package:flutter/material.dart';

class OnboardScreen2 extends StatelessWidget {
  const OnboardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset('assets/images/onboard_img2.png'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              width: 300,
              child: Center(
                child: Text(
                  "Foodie is Where Your Comfort Food Resides",
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
                "Enjoy a fast and smooth food delivery at your doorstep",
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
                        builder: (context) => const LoginScreen()),
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