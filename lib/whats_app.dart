import 'package:flutter/material.dart';
import 'package:whats_app/feaures/Nav_Bar/ui/nav_bar.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavBar(),);
  }
}