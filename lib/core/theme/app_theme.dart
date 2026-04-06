import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_colors.dart';

class AppTheme {
  final TextStyle seenTextStyle= TextStyle(color: AppColors.seenTextColor,fontSize: 14.sp);
  final TextStyle messageTextStyle= TextStyle(color: Colors.black,fontSize: 16.sp);
  final TextStyle titleTextStyle= TextStyle(color: Colors.black,fontSize: 17.sp,fontWeight: FontWeight.w500);
}