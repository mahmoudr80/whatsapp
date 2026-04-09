import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/feature/call/data/model/call_model.dart';

import '../../../../gen/assets.gen.dart';

class CallsList extends StatelessWidget {
  final List<CallModel>calls;
  const CallsList({super.key, required this.calls});
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: calls.length,
      separatorBuilder: (_, __) => Divider(indent: 70, height: 1),
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(100.r),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              width: 50.r,
            height: 50.r,
            calls[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            calls[index].name,
            style: TextStyle(
              color: calls[index].status==CallStatus.missed ? Colors.red : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                calls[index].status==CallStatus.missed ? Icons.call_missed : Icons.phone,
                size: 14,
                color: Colors.grey,
              ),
              SizedBox(width: 4),
              Text(
                calls[index].status.name,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // مهم جدًا
            children: [
              Text(
                calls[index].date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14, // الحجم
                ),
              ),
              SizedBox(width: 8),
              SvgPicture.asset(Assets.icons.infoIcon),
            ],
          ),
        );
      },
    );
  }
}
