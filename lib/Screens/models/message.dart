import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String recieverID;
  final String senderID;
  final String senderEmail;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.recieverID,
    required this.senderID,
    required this.senderEmail,
    required this.timestamp,
    required this.message,
  });

  Map<String,dynamic> toMap (){
    return {
      'recieverID' : recieverID,
      'senderID' : senderID,
      'senderEmail' : senderEmail,
      'timestamp' : timestamp,
      'message' : message,
    };
  }


}