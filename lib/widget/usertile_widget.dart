import 'package:flutter/material.dart';

class userTile extends StatelessWidget {

  const userTile({super.key, required this.ontap, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(        
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 244, 244, 244),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black,
              width: 1,
            )
      
          ),
          child: Row(children: [
            CircleAvatar(
              radius: 22,
              child: Image.asset('assets/images/p1.png'),
            ),
            SizedBox(width: 18,),
            Text(email,style: TextStyle(fontSize: 16),),
          ],),
        ),
      
      ),
    );
  }

  final void Function() ontap;
  final String email;
}