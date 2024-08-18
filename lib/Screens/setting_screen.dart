import 'package:chatapp/constants/colors.dart';
// import 'package:chatapp/provider/firebase_login_provider.dart';
import 'package:chatapp/provider/firebase_ogin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 40,
            child: InkWell(
              onTap: () {
                firebaseAuthService.signOut(context);
              },
              child: const Icon(
                Icons.logout,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
