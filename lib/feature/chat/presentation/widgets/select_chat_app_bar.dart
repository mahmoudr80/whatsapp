import 'package:flutter/material.dart';
import 'package:whatsapp/core/theme/app_text_style.dart';
import 'package:whatsapp/core/theme/app_color.dart';

class SelectChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelectChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColor.primaryBlueColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        children: [
          Text(
            'Chat With',
            style: AppTextStyle.font18BlackSemiBold,
          ),
          Text(
            'all Users',
            style: AppTextStyle.font12GreyRegular,
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColor.primaryBlueColor),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
