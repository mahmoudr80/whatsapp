import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../gen/assets.gen.dart';
import '../../data/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  final bool seen;

  const MessageWidget({
    super.key,
    required this.message,
    this.isMe = true,
    this.seen = false,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a').format(message.time);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: !isMe ? 10.w : 100.w,
          right: !isMe ? 100.w : 10.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: !isMe
              ? AppColor.receivedMessageBackColor
              : AppColor.sentMessageBackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(!isMe ? 4.r : 16.r),
            bottomRight: Radius.circular(!isMe ? 16.r : 4.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: 255.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: AppTextStyle.font16BlackRegular,
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Text(
                  formattedTime,
                  style: AppTextStyle.font12GreyRegular.copyWith(fontSize: 10.sp),
                ),
                if (isMe) ...[
                  SizedBox(width: 4.w),
                  seen
                      ? SvgPicture.asset(
                          Assets.icons.seenIcon,
                          width: 15.w,
                        )
                      : Assets.icons.unseenIcon.image(
                          width: 15.w,
                        ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
