import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppTextStyle {
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.black,
  );

  static TextStyle font18BlackSemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.grey,
  );

  static TextStyle font16BlackRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.black,
  );
  
  static TextStyle font12GreyRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.grey,
  );
}
