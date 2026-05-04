import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/message_model.dart';
import '../cubit/message_cubit.dart';
import 'message_widget.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        if (state is MessageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessageSuccess) {
          final items = buildItems(state.messages);
          return ListView.separated(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              //  DATE HEADER
              if (item is DateTime) {
                return Center(
                  child: Text(formatDate(item)),
                );
              }

              // MESSAGE
              final message = item as MessageModel;

              return MessageWidget(
                message: message,
                isMe: message.senderId ==
                    FirebaseAuth.instance.currentUser?.uid,
                seen: true,
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
          );
        } else if (state is MessageFailure) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

List<dynamic> buildItems(List<MessageModel> messages) {
  final items = <dynamic>[];

  for (int i = 0; i < messages.length; i++) {
    final current = messages[i];

    items.add(current); // 🔥 add message FIRST

    // 🔥 detect day change using NEXT (older message)
    if (i == messages.length - 1 ||
        !isSameDay(current.time, messages[i + 1].time)) {
      items.add(current.time); // 🔥 header AFTER group
    }
  }

  return items;
}
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;
}
String formatDate(DateTime date) {
  final now = DateTime.now();

  if (isSameDay(date, now)) return "Today";

  if (isSameDay(date, now.subtract(Duration(days: 1)))) {
    return "Yesterday";
  }

  return "${date.day}/${date.month}/${date.year}";
}