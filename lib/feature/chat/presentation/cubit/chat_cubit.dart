import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/core/networking/result.dart';
import 'package:whatsapp/feature/chat/data/repository/chat_repo.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._repo) : super(ChatInitial());
final ChatRepo _repo;
StreamSubscription ? _subscription;



  Future<void> getChats() async {
    if (isClosed) return;
    emit(ChatListLoading());
    _subscription?.cancel();
    _subscription= _repo.getChats().listen(
      (result) {
        if (isClosed) return;
        switch(result){
          case Success(data :final chats):
            if (isClosed) return;
            emit(ChatListSuccess(chats));
            break;
          case Failure(message :final error):
            if (isClosed) return;
            emit(ChatListFailure(error));
            break;
        }
      },
      onError: (e) {
        emit(ChatListFailure(e.toString()));
      },
    );
    }


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
