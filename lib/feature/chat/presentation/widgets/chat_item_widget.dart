import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_circle_avatar.dart';
import '../../data/models/chat_model.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatItemWidget({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a').format(chat.updatedAt);
     UserModel ?otherUser;
    chat.participantData.forEach((key, value) {
      if(key!=FirebaseAuth.instance.currentUser?.uid){
        otherUser = value;
        return;
      }
    },);
    return ListTile(
      onTap: onTap,
      leading: CustomCircleAvatar(
        imageUrl: otherUser?.image??'',
        radius: 25.r,
      ),
      title: Text(
        otherUser?.name??'',
        style: AppTextStyle.font18BlackSemiBold,
      ),
      subtitle: Text(
        chat.lastMessage,
        style: AppTextStyle.font14GreyRegular,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        formattedTime,
        style: AppTextStyle.font12GreyRegular,
      ),
    );
  }
}
