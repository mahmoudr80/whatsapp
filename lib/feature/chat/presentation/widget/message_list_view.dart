import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/feature/chat/presentation/widget/message_widget.dart';
List<bool>sentList=[true,true,false,false,true,false,true,false,false,true,false,true,false,false,true,false,true,false,false,true,false];
List<bool>seenList=[true,false,true,false,true,false,false,true,false,true,false,false,true,false,true,false,false,true,false,true,false];
class MessageListView extends StatelessWidget {
  const MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
        itemBuilder: (context, index) => MessageWidget(isMe: sentList[index],seen: seenList[index],),
        separatorBuilder: (context, index) => SizedBox(height: 5.h,),
        itemCount: sentList.length);
  }
}
