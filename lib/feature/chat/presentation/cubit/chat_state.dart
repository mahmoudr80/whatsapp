part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

// Chat List States
final class ChatListLoading extends ChatState {}

final class ChatListSuccess extends ChatState {
  final List<ChatModel> chats;
   ChatListSuccess(this.chats);
}

final class ChatListFailure extends ChatState {
  final String error;
   ChatListFailure(this.error);
}


