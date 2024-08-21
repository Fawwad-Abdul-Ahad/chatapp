import 'package:chatapp/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayMessage extends StatefulWidget {
  final String email;
  const DisplayMessage({super.key, required this.email});

  @override
  State<DisplayMessage> createState() => _DisplayMessageState();
}
class _DisplayMessageState extends State<DisplayMessage> {
  // Instance creation
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection("Message")
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot ads = snapshot.data!.docs[index];
            Timestamp time = ads['time'];
            DateTime dateTime = time.toDate();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: widget.email == ads['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color.fromARGB(255, 255, 0, 85),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      tileColor: const Color.fromARGB(255, 255, 223, 233), // Light pink background color
                      title: Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              ads['message'],
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text("${dateTime.hour}:${dateTime.minute}"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

