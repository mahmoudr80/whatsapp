part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}
final class MessageLoading extends MessageState {}

final class MessageSuccess extends MessageState {
  final List<MessageModel> messages;
  MessageSuccess(this.messages);
}

final class MessageFailure extends MessageState {
  final String error;
  MessageFailure(this.error);
}
