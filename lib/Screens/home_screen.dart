
import 'package:chatapp/Screens/chat_screen2.dart';
import 'package:chatapp/constants/colors.dart';
// import 'package:chatapp/provider/firebase_auth_service.dart';
import 'package:chatapp/provider/firebase_ogin_provider.dart';
// import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/chat_services2.dart';
import 'package:chatapp/widget/drawer_widget.dart';
import 'package:chatapp/widget/usertile_widget.dart'; // Ensure this widget is correctly implemented.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String _currentUserEmail = _auth.currentUser!.email!.toString();
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        title: Text(
          "Home",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Consumer<FirebaseAuthService>(builder: (context, value, child) {
            return SizedBox(
              width: 40,
              child: InkWell(
                onTap: () {
                  value.signOut(context);
                },
                child: Icon(
                  Icons.logout,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ],
      ),
      drawer: drawer(),
      body: _buildUserList(_currentUserEmail)
    );
  }

  Widget _buildUserList(String currentUserEmail) {
    String userEmail = currentUserEmail;
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _authService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error Occurred"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final usersData = snapshot.data ?? [];

        if (usersData.isEmpty) {
          return Center(child: Text("No Users Found"));
        }

        return ListView(
          children: usersData
              .where((userData) => userData['email'] != currentUserEmail)
              .map<Widget>((userData) => _buildUserListItem(userData, context, userEmail))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context, String userEmail) {
    final email = userData['email'] as String? ?? ''; // Provide default if null
    final uID = userData['uID'] as String? ?? '';    // Provide default if null

    if(userData['email'] != userEmail){
         return userTile(
      ontap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              email : userData['email'],
            ),
          ),
        );
      },
      email: email,
    );
    }else{
      return Container();
    }
  }
}
