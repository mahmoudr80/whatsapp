import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/routes/routes_screens.dart';
import 'package:whatsapp/feature/chat/data/models/chat_model.dart';
import 'package:whatsapp/feature/chat/presentation/widgets/chat_item_widget.dart';

class ChatListSuccessWidget extends StatelessWidget {
  final List<ChatModel> chats;
  const ChatListSuccessWidget({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: chats.length,
      separatorBuilder: (context, index) => Divider(indent: 70.w),
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatItemWidget(
          chat: chat,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.chatDetails,
              arguments: chat,
            );
          },
        );
      },
    );
  }
}
