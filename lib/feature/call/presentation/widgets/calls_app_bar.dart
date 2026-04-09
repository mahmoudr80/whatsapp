import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';

class CallsAppBar extends StatelessWidget {
  final int selectedSegment;
  final ValueChanged<int> onSegmentChanged;

  const CallsAppBar({
    super.key,
    required this.selectedSegment,
    required this.onSegmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      child: Row(
        children: [
          Text("Edit", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17, color: Colors.blue)),
         Spacer(),
          // ALL
          InkWell(
            onTap: () => onSegmentChanged(0),
            child: Container(
              width: 55,
              height: 28,
              decoration: BoxDecoration(
                color: selectedSegment == 0 ? Colors.blue : Colors.transparent,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
              ),
              child: Center(
                child: Text("All", style: TextStyle(fontSize: 13, color: selectedSegment == 0 ? Colors.white : Colors.blue)),
              ),
            ),
          ),
          // MISSED
          InkWell(
            onTap: () => onSegmentChanged(1),
            child: Container(
              width: 55,
              height: 28,
              decoration: BoxDecoration(
                color: selectedSegment == 1 ? Colors.blue : Colors.transparent,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Center(
                child: Text("Missed", style: TextStyle(fontSize: 13, color: selectedSegment == 1 ? Colors.white : Colors.blue)),
              ),
            ),
          ),
        Spacer(),
          SvgPicture.asset(Assets.icons.activeCallIcon, width: 24, height: 24),
        ],
      ),
    );
  }
}