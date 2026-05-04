import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_color.dart';

import '../../../../core/widgets/custom_circle_avatar.dart';


class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  const ProfileImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.primaryBlueColor, width: 3),
            ),
            child: CustomCircleAvatar(
              imageUrl: imageUrl,
              radius: 57.r,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                color: AppColor.primaryBlueColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_alt, color: Colors.white, size: 20.r),
            ),
          ),
        ],
      ),
    );
  }
}
