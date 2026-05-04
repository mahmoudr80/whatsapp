import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? radius;
  final IconData? placeholderIcon;

  const CustomCircleAvatar({
    super.key,
    this.imageUrl,
    this.radius,
    this.placeholderIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 20.r,
      backgroundColor: Colors.grey[200],
      backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
          ? NetworkImage(imageUrl!)
          : null,
      child: (imageUrl == null || imageUrl!.isEmpty)
          ? Icon(placeholderIcon ?? Icons.person, size: (radius ?? 20.r) * 0.8, color: Colors.grey[600])
          : null,
    );
  }
}
