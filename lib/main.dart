import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_colors.dart';
import 'package:whatsapp/feature/authorization/authorization_screen.dart';
import 'package:whatsapp/feature/call/presentation/calls_screen.dart';
import 'package:whatsapp/feature/chat/presentation/chat_screen.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/feature/nav_screen/navigation_screen.dart';

import 'firebase_options.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            appBarTheme: AppBarTheme(backgroundColor: Colors.white,)
        ),
        home:
        BlocProvider(
          create: (context) => NavigationCubit(),
          child: NavigationScreen(),
        ),
      ),
    );
  }
}

//flutter pub run easy_localization:generate \
// -S assets/translations \
// -O lib/generated \
// -f keys \
// -o locale_keys.g.dart