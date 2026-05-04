import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/core/services/firebase_constants.dart';

import 'user_model.dart';

class ChatModel {
  final String ?chatID;
  final String lastMessage;
  final Map<String,UserModel> participantData;
  final List<String> participants;
  final DateTime updatedAt;


  ChatModel({required this.lastMessage,
    required this.participantData,
    required this.participants,
    required  this.updatedAt,  this.chatID});


  factory ChatModel.fromFirestore(DocumentSnapshot document,chatID) {
    final data = document.data() as Map<String,dynamic>;
    final Map<String,UserModel>users=
    (data[FirebaseConstants.participantDataKey] as
    Map<String,dynamic>)
    .map((key, value) =>
        MapEntry(key, UserModel.fromFirestore(value)));
    return  ChatModel(
      participants: List<String>.from(
          data[FirebaseConstants.participantsKey]??[]
      ),
      participantData:users ,
      lastMessage:data[FirebaseConstants.lastMessageKey]
        ,chatID: chatID,
      updatedAt:((data[FirebaseConstants.updatedAtKey]) as Timestamp).toDate(),

    );

  }

   ChatModel copyWith(
  final String ?newChatID,
  final String? newLastMessage,
  final Map<String,UserModel> ?newParticipantData,
  final List<String>? newParticipants,
  final DateTime ?newUpdatedAt,
  ) {
    return  ChatModel(
      participants: newParticipants??participants,
      participantData:newParticipantData??participantData ,
      lastMessage:newLastMessage??lastMessage,
      updatedAt:newUpdatedAt??updatedAt,
    );

  }


}
