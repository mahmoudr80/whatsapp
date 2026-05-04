import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/core/services/firebase_constants.dart';

abstract class FirebaseServices {


  static Future<bool>saveUser({
    String ?name,String ?image,String ?email
}) async {
    final user=FirebaseAuth.instance.currentUser;
    try{
     await  FirebaseFirestore.instance
           .collection(FirebaseConstants.userCollection).doc(user?.uid)
           .set({
         FirebaseConstants.nameKey:name??user?.displayName,
         FirebaseConstants.emailKey:email??user?.email,
         FirebaseConstants.imagePathKey:image??user?.photoURL
       });
       return true;
    }catch(e){
      return false;
    }
  }
  static Future<DocumentSnapshot<Map<String, dynamic>>?>getUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    try {
      final docs = await FirebaseFirestore.instance.doc(user.uid).get();
      return docs;
    }
    catch (e) {
      return null;
    }
  }
}


