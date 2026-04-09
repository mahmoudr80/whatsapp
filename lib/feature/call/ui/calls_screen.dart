import 'package:flutter/material.dart';

import '../widgets/calls_app_bar.dart';
import '../widgets/calls_list.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
      ),
    );
  }
}