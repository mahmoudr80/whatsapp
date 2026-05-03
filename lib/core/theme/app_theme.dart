import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppTheme {
  static final TextStyle seenTextStyle =
      TextStyle(color: AppColor.seenTextColor, fontSize: 14.sp);
  static final TextStyle messageTextStyle =
      TextStyle(color: Colors.black, fontSize: 16.sp);
  static final TextStyle textButtonStyle = TextStyle(fontSize: 17.sp);
  static final TextStyle textPhoneStyle =
      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w300);
  static final TextStyle titleTextStyle =
      TextStyle(color: Colors.black, fontSize: 17.sp, fontWeight: FontWeight.w500);
}