import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/core/theme/app_theme.dart';

import '../../../../gen/assets.gen.dart';


class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon:SvgPicture.asset(Assets.icons.arrowBackIcon),),
          SizedBox(width: 41.w,),
          CircleAvatar(radius: 24.r,),
          SizedBox(width: 8.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Martha Craig",style: AppTheme.titleTextStyle,),
                Text("tap here for contact info",
                  style: AppTheme.seenTextStyle.copyWith(fontSize: 12.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
              ],
            ),
          ),
        IconButton(onPressed: () {}, icon:SvgPicture.asset(Assets.icons.videoCallIcon),),
          IconButton(onPressed: () {}, icon:SvgPicture.asset(Assets.icons.activeCallIcon),),
        ],
      ),
    );
  }
}
