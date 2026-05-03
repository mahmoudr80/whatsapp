import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp/core/services/firebase_constants.dart';

class ChatRemoteDatasource {

  Stream<QuerySnapshot<Map<String, dynamic>>>getChats()  {
      final uid=FirebaseAuth.instance.currentUser?.uid;
      if(uid==null){
        throw Exception("User not authenticated");
      }
      return FirebaseFirestore.instance.collection(
          FirebaseConstants.chatCollection)
          .where('participants', arrayContains: uid).
      orderBy('updatedAt', descending: true)
          .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>>getUsers() async {
    return await FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollection)
    .get();
  }


  Stream<QuerySnapshot<Map<String, dynamic>>>getMessages(){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid==null){
      throw Exception("User not authenticated");
    }
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.chatCollection)
        .doc(uid)
        .collection(FirebaseConstants.messageCollection)
        .snapshots();
  }
}