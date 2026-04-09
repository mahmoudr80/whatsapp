import 'package:flutter/material.dart';
import 'package:whats_app/feaures/Calls/widgets/calls_app_bar.dart';
import 'package:whats_app/feaures/Calls/widgets/calls_list.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  int selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CallsAppBar(
              selectedSegment: selectedSegment,
              onSegmentChanged: (int value) {
                setState(() {
                  selectedSegment = value;
                });
              },
            ),
          ),
          Expanded(
            child: CallsList(selectedSegment: selectedSegment),
          ),
        ],
      ),
    );
  }
}