import 'package:chatapp/Screens/home_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  String get userName => _userName;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _nameCOntroller = TextEditingController();
  TextEditingController get nameController => _emailController;
  
  final TextEditingController _passController = TextEditingController();
  TextEditingController get passController => _passController;

  User? currentUser() {
    return _auth.currentUser;
  }

  // Sign In Method
  Future<void> signIn(BuildContext context) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      _userName = emailController.text;

      _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': emailController.text,
      }, SetOptions(merge: true));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
      notifyListeners();
   
      
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      _showErrorDialog(context, 'Error', errorMessage);
    }
  }

  // Sign Up Method
  Future<void> signUp(BuildContext context) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      _firestore.collection('users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': emailController.text,
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
      notifyListeners();
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again later.';
      }
      _showErrorDialog(context, 'Signup Error', errorMessage);
    } catch (e) {
      _showErrorDialog(context, 'Error', 'An unexpected error occurred. Please try again later.');
    }
  }

  // Sign Out Method
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
      
      notifyListeners();
    } catch (e) {
      print("Error signing out: $e");
      // Handle the error, possibly showing a dialog or a snack bar
    }
  }

  // Helper method to show error dialogs
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
}
