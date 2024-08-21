import 'package:chatapp/Screens/setting_screen.dart';
import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/data/data1.dart';
import 'package:chatapp/provider/firebase_ogin_provider.dart';
import 'package:chatapp/services/chat_services2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    String _currentUserEmail = _auth.currentUser!.email!.toString();
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color.fromARGB(255, 255, 210, 225),
                      child: Icon(
                        Icons.person,
                        size: 42,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _currentUserEmail,
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  "HOME",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.home,
                    color: primaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  "SETTINGS",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.settings,
                    color: primaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );
                },
              ),
            ],
          ),
          Consumer<FirebaseAuthService>(builder: (context, value, child) {
            return ListTile(
              title: const Text(
                "LOGOUT",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.logout,
                  color: primaryColor,
                ),
              ),
              onTap: () {
                value.signOut(context);
              },
            );
          })
        ],
      ),
    );
  }
}
