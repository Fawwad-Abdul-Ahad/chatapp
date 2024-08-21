import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/data/data1.dart';
import 'package:chatapp/widget/display_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String email;
  const ChatScreen({super.key, required this.email});
  
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.email,
          style: const TextStyle(
            fontSize: 20, 
            color: Colors.white, 
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Wrapping DisplayMessage with Expanded
          Expanded(
            child: DisplayMessage(email: widget.email),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(fontSize: 16),
                        hintText: "Enter a message",
                        fillColor: const Color.fromARGB(255, 255, 240, 245),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 252, 0, 84),
                          ),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        messageController.text = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    radius: 30,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (messageController.text.isNotEmpty) {
                            fireStore.collection('Message').doc().set({
                              'message': messageController.text,
                              'time': DateTime.now(),
                              "email": widget.email,
                            });
                            messageController.clear();
                          }
                        },
                        child: Icon(Icons.send, size: 32, color: primaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
