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


  Stream<QuerySnapshot<Map<String, dynamic>>>getMessages(
      {required String? chatId}){
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid==null){
      throw Exception("User not authenticated");
    }
    if(chatId ==null){
      throw Exception("There is no chat");
    }
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.chatCollection)
        .doc(chatId)
        .collection(FirebaseConstants.messageCollection)
        .orderBy(FirebaseConstants.timeKey
    ,descending: true).snapshots();
  }

    Future<void>send({required String message,
      required String? chatID}) async {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if(uid==null||chatID==null){
        throw Exception("User not authenticated");
      }
      try{
        Timestamp time = Timestamp.fromDate(DateTime.now());
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.chatCollection)
          .doc(chatID).update({
        FirebaseConstants.updatedAtKey:time,
        FirebaseConstants.lastMessageKey:message
      });
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.chatCollection)
          .doc(chatID).collection(FirebaseConstants.messageCollection)
          .add({
        FirebaseConstants.imagePathKey:FirebaseAuth.instance.currentUser?.photoURL,
        FirebaseConstants.nameKey:FirebaseAuth.instance.currentUser?.displayName,
        FirebaseConstants.senderIdKey:uid,
        FirebaseConstants.textKey:message,
        FirebaseConstants.timeKey:time,
      });

      }catch(e){
        throw Exception(e.toString());
      }

    }
}