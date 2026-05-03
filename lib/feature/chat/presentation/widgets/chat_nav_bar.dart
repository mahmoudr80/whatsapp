import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../gen/assets.gen.dart';

class ChatNavBar extends StatelessWidget {
  const ChatNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: const BoxDecoration(color: AppColor.navBarBackColor),
      child: Row(
        children: [
          SvgPicture.asset(Assets.icons.addIcon),
          SizedBox(width: 15.w),
          Expanded(
            child: TextFormField(
                decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: AppColor.seenTextColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(width: 0.5, color: AppColor.seenTextColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(width: 0.5, color: AppColor.seenTextColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(width: 0.5, color: AppColor.seenTextColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(width: 0.5, color: AppColor.seenTextColor)),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Padding(
                padding: EdgeInsets.all(8.r),
                child: SvgPicture.asset(
                  Assets.icons.posterIcon,
                  width: 18.w,
                  height: 18.h,
                  fit: BoxFit.contain,
                ),
              ),
            )),
          ),
          SizedBox(width: 15.w),
          SvgPicture.asset(Assets.icons.activeCameraIcon),
          SizedBox(width: 15.w),
          SvgPicture.asset(Assets.icons.micIcon),
        ],
      ),
    );
  }
}
