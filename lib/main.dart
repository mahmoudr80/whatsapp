import 'package:flutter/material.dart';
import 'package:whatsapp/core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("data",style: TextStyle(color: AppColors.seenTextColor),),
      ],
    ),),);
  }
}

//flutter pub run easy_localization:generate \
// -S assets/translations \
// -O lib/generated \
// -f keys \
// -o locale_keys.g.dart