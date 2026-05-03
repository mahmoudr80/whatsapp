import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/chat_cubit.dart';
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
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return MessageWidget(
                message: message,
                isMe: message.senderId ==
                FirebaseAuth.instance.currentUser?.uid,
                seen: true, // Mocked
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemCount: state.messages.length,
          );
        } else if (state is MessageFailure) {
          return Center(child: Text(state.error));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
