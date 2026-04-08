import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/core/theme/app_colors.dart';
import 'package:whatsapp/gen/assets.gen.dart';

class ChatNavBar extends StatelessWidget {
  const ChatNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(color: AppColors.navBarBackColor),
      child: Row(
        spacing: 25.w,
        children: [
          SvgPicture.asset(Assets.icons.addIcon),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border: OutlineInputBorder(borderSide: BorderSide(width: 0.5,color: AppColors.seenTextColor)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),borderSide: BorderSide(width: 0.5,color: AppColors.seenTextColor)),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),borderSide: BorderSide(width: 0.5,color: AppColors.seenTextColor)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),borderSide: BorderSide(width: 0.5,color: AppColors.seenTextColor)),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r),borderSide: BorderSide(width: 0.5,color: AppColors.seenTextColor)),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: SvgPicture.asset(
                  Assets.icons.posterIcon,
                  width: 18.w,
                  height: 18.h,
                  fit: BoxFit.scaleDown,
                ),
              )
            ),
          ),
          SvgPicture.asset(Assets.icons.activeCameraIcon),
          SvgPicture.asset(Assets.icons.micIcon),
        ],
      ),
    );
  }
}
