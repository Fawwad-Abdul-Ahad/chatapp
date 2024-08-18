import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/provider/firebase_ogin_provider.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/widget/mesaage_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final String recieverEmail;
  final String recID;
  ChatScreen({super.key, required this.recieverEmail, required this.recID});
  TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService(); 
  void sendMessage() async {
    //send message
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthService authService = Provider.of<FirebaseAuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        // iconTheme:  ,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          recieverEmail,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(authService)),
          messageWidget(_messageController, sendMessage),
        ],
      ),
    );
  }

  Widget _buildMessageList(authService) {
    String sendID = authService.currentUser()!.uid;
    return StreamBuilder<QuerySnapshot>(
  stream: _chatService.getMessage(recID, sendID),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text("Error: ${snapshot.error}"));
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text("No messages"));
    }

    final messages = snapshot.data!.docs;
    return ListView(
      children: messages
          .map((doc) => _buildMessageItem(doc, authService))
          .toList(),
    );
  },
);
  }

  Widget _buildMessageItem(DocumentSnapshot doc, authService) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == authService.currentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerRight;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isCurrentUser?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(data['message']),
        ],
      ),
    );
  }
}
