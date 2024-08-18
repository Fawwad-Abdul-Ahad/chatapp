import 'package:flutter/material.dart';

Widget messageWidget(TextEditingController messageController, sendMessage()) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            style: TextStyle(
              fontSize: 16,
            ),
            autocorrect: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Enter your message', // Hint text
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey), // Default border color
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent), // Border color when focused
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
          ),
        ),
        SizedBox(width: 6,),
        CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 207, 232),
          radius: 22,
          child: InkWell(
            onTap: sendMessage,
            child: Icon(Icons.arrow_upward,size: 30,)),
        )

      ],
    ),
  );
}
