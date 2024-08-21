import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
class AuthService {

    Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _fireStore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }

Future<String> SignupUser(
    {required String email, required String pass, required String name}) async {
  String res = "Not succesful";
  try {
    if(email.isNotEmpty || name.isNotEmpty || pass.isNotEmpty){
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
      
    );

    await _fireStore.collection("users").doc(credential.user!.uid).set({
      'name' : name,
      'email': email,
      'uid' : credential.user!.uid,
    });
    res = "success";
    }
  } catch (e) {
    print(e.toString());
  }

  return res;
}

 Future <String> loginUser({
  required String email, required String pass,
 })async{
  String res = "Some error occured";
  try{
    if(email.isNotEmpty || pass.isNotEmpty){
      await _auth.signInWithEmailAndPassword(email: email, password: pass
      );
      res = "success";
    }
    else{
      res = "Please enter all the field";  
    }
  }catch(e){
    return e.toString();
  }
return res;

 }

}
 



