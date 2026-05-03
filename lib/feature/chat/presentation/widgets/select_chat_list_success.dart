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
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              Routes.chatDetails,
              arguments: user,
            );
          },
        );
      },
    );
  }
}
