import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/core/theme/app_colors.dart';
import 'package:whatsapp/core/theme/app_theme.dart';

import '../../../../gen/assets.gen.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key,  this.isMe=true,  this.seen=false});
final bool isMe;
final bool seen;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin:EdgeInsets.only(
          left:!isMe? 0:100.w,
        right: !isMe?100.w:0

      ) ,
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 8.h),
      decoration: BoxDecoration(
          color:!isMe? AppColors.receivedMessageBackColor:AppColors.sentMessageBackColor,
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(
        !isMe?    4:16
        ),  // round this if sent by me
        bottomRight: Radius.circular(
            !isMe?16:4
        ),  // slightly pointy for sender side
      )),
      constraints: BoxConstraints(maxWidth: 255.w),
      child: Stack(
          children:
         [
           Padding(
             padding:  EdgeInsets.only(
                 right: 30.w),
             child: Text("dacdtasdddddddddddddddddddddddddd",
              maxLines: 20,overflow: TextOverflow.ellipsis,),
           ),
         Positioned(right: 19,bottom:0,child: Text("10:10",style: AppTheme.seenTextStyle.copyWith(fontSize: 11.sp),)),
         Positioned(right: 0,bottom:0,child:isMe?seen?
         SvgPicture.asset(Assets.icons.seenIcon,width: 11.w,height: 8.h,)
             :Assets.icons.unseenIcon.image(width: 16.w,height: 13.h):Text("")),
         ]
      ),
    );
  }
}
