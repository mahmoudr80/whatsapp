import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/core/networking/result.dart';
import 'package:whatsapp/feature/chat/data/datasource/chat_remote_datasource.dart';
import 'package:whatsapp/feature/chat/data/models/chat_model.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';

import '../models/message_model.dart';

class ChatRepo {
  final ChatRemoteDatasource _datasource;

  const ChatRepo(this._datasource);

  Stream<Result<List<ChatModel>>> getChats ()async*
  {
    try{
      await for(final snapshot in  _datasource.getChats()){
      final chats= snapshot.docs.
     map((doc) => ChatModel.fromFirestore(doc))
          .toList();
      yield Result.success(chats);
      }
    }catch(e){
     yield Result.failure(e.toString());
    }
    }

  Future<Result>getUsers() async{
    try{
      List<UserModel>users=[];
      final snapshot = await _datasource.getUsers();

      for (final doc in snapshot.docs) {
        users.add(
            UserModel.fromFirestore(doc.data()).copyWith(
              uid: doc.id
            )
        );

      }
      return Result.success(users);
    }catch(e){
      return Result.failure(e.toString());
    }
  }

  Stream<Result<List<MessageModel>>>  getMessages()async*{
    try{
      await for(final snapshot in  _datasource.getMessages())
      {
        final chat=snapshot.docs.
        map((doc) {
          return MessageModel.fromFirestore(doc.data());
        },).toList();
        yield Result.success(chat);
      }
    }catch(e){
      yield Result.failure(e.toString());
    }

  }
}