import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/feature/chat/presentation/widget/chat_app_bar.dart';
import 'package:whatsapp/feature/chat/presentation/widget/chat_nav_bar.dart';
import 'package:whatsapp/feature/chat/presentation/widget/message_list_view.dart';
import 'package:whatsapp/feature/chat/presentation/widget/message_widget.dart';
import 'package:whatsapp/gen/assets.gen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Positioned.fill(child: Assets.images.backgroundChatImg2.image(fit: BoxFit.fill)),
            Column(mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatAppBar(),
                Expanded(child:
                MessageListView()
                ),
                ChatNavBar()

              ],
            ),]
        ),
      ),
    );
  }
}
