import 'package:chatapp/Screens/models/message.dart';
import 'package:chatapp/provider/firebase_ogin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _fireStore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String recID, String message) async {
  final String currUserId = auth.currentUser!.uid;
  final String currUserEmail = auth.currentUser!.email!;
  final Timestamp time = Timestamp.now();

  Message newMessage = Message(
      recieverID: recID,
      senderID: currUserId,
      senderEmail: currUserEmail,
      timestamp: time,
      message: message);

  List<String> ids = [currUserId, recID];
  ids.sort();
  String chatRoomId = ids.join('-');

  print('Sending message to chatRoomId: $chatRoomId');
  print('Message: ${newMessage.toMap()}');
  print({'$recID'});

  await _fireStore.collection('chat_room')
      .doc(chatRoomId)
      .collection('messages')
      .add(newMessage.toMap());
}

  // get messsages
  Stream<QuerySnapshot> getMessage (String userId, otherids){
      List <String> ids = [userId, otherids];
      ids.sort();
      String chatRoomId = ids.join('-');

      
      return _fireStore.collection('chat_room').doc(chatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }

}
