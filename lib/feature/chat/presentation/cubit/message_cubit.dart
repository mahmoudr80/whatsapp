import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/feature/chat/data/repository/chat_repo.dart';

import '../../../../core/networking/result.dart';
import '../../data/models/message_model.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this._repo) : super(MessageInitial());
final ChatRepo _repo;
  StreamSubscription ? _subscription;

  Future<void> getMessages() async {
    if (isClosed) return;
    emit(MessageLoading());

    _subscription?.cancel();
    _subscription=_repo.getMessages().listen(
          (response) {
        switch(response){
          case Success(data:final messages):
            if (isClosed) return;
            emit(MessageSuccess(messages));
          case Failure(message:final error):
            if (isClosed) return;
            emit(MessageFailure(error));
        }
      },
      onError: (e) =>emit(MessageFailure(e.toString())) ,
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
