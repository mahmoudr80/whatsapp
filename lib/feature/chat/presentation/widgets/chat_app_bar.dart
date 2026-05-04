import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_circle_avatar.dart';
import '../../../../gen/assets.gen.dart';

class ChatAppBar extends StatelessWidget {
  final String name;
  final String image;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(Assets.icons.arrowBackIcon),
          ),
          CustomCircleAvatar(
            imageUrl: image,
            radius: 20.r,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: AppTextStyle.font18BlackSemiBold.copyWith(fontSize: 16.sp),
                ),
                Text(
                  "tap here for contact info",
                  style: AppTextStyle.font12GreyRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.videoCallIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(Assets.icons.activeCallIcon),
          ),
        ],
      ),
    );
  }
}
