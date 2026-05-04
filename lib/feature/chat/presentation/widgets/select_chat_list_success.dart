import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/feature/chat/data/models/chat_model.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import 'package:whatsapp/feature/chat/presentation/widgets/chat_item_widget.dart';
import 'package:whatsapp/core/routes/routes_screens.dart';
import 'package:whatsapp/feature/chat/presentation/widgets/user_item_widget.dart';

class SelectChatListSuccess extends StatelessWidget {
  final List<UserModel> users;

  const SelectChatListSuccess({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: users.length,
      separatorBuilder: (context, index) => Divider(indent: 70.w),
      itemBuilder: (context, index) {
        final user = users[index];

        return UserItemWidget(
          user: user,
          onTap: ()  {
            final chat =  getChat(user);
            Navigator.pushReplacementNamed(
              context,
              Routes.chatDetails,
              arguments: chat,
            );
          },
        );
      },
    );
  }

  ChatModel getChat(UserModel user){
    final currentUser=FirebaseAuth.instance.currentUser;
    final chat = ChatModel(
        lastMessage: '',
        participantData: {
          currentUser?.uid??'':UserModel(name:
          currentUser?.displayName??'',
              image: currentUser?.photoURL??'',
              email: currentUser?.email??''),
          user.uid??'':
            UserModel(name:
                user.name,
                    image: user.image,
                    email: user.email),

        },
        participants: [
        currentUser?.uid??'',user.uid??''],
        updatedAt: DateTime.now());
    return chat;
  }

}
