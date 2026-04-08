import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallsList extends StatelessWidget {
  final int selectedSegment;
  const CallsList({super.key, required this.selectedSegment});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allCalls = [
      {
        "name": "Martin Randolph",
        "isMissed": false,
        "date": "10/13/19",
        "image": "assets/pictures/Oval(1).svg",
      },
      {
        "name": "Karen Castillo",
        "isMissed": true,
        "date": "10/11/19",
        "image": "assets/pictures/Oval(2).svg",
      },
      {
        "name": "Jaeme Franco",
        "isMissed": false,
        "date": "9/15/19",
        "image": "assets/pictures/Oval(3).svg",
      },
      {
        "name": "Zack John",
        "isMissed": true,
        "date": "8/22/19",
        "image": "assets/pictures/Oval.svg",
      },
    ];
    final displayedCalls = selectedSegment == 1
        ? allCalls.where((call) => call['isMissed'] == true).toList()
        : allCalls;
    return ListView.separated(
      itemCount: displayedCalls.length,
      separatorBuilder: (_, __) => Divider(indent: 70, height: 1),
      itemBuilder: (context, index) {
        final call = displayedCalls[index];
        print(call['image']);

        return ListTile(
          leading: SvgPicture.asset(
           "assets/pictures/Oval.svg",
            fit: BoxFit.cover,
          ),
          title: Text(
            call['name'],
            style: TextStyle(
              color: call['isMissed'] ? Colors.red : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                call['isMissed'] ? Icons.call_missed : Icons.phone,
                size: 14,
                color: Colors.grey,
              ),
              SizedBox(width: 4),
              Text(
                call['isMissed'] ? "Missed" : "outgoing",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // مهم جدًا
            children: [
              Text(
                call['date'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14, // الحجم
                ),
              ),
              SizedBox(width: 8),
              SvgPicture.asset("assets/icons/InfoIcon.svg"),
            ],
          ),
        );
      },
    );
  }
}
