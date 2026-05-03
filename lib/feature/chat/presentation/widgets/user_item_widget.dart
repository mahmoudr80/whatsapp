import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_circle_avatar.dart';
import '../../data/models/chat_model.dart';

class UserItemWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UserItemWidget({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CustomCircleAvatar(
        imageUrl: user.image,
        radius: 25.r,
      ),
      title: Text(
        user.name,
        style: AppTextStyle.font18BlackSemiBold,
      ),

    );
  }
}
