import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/di/dependency_injection.dart';
import 'package:whatsapp/feature/authorization/presentation/authorization_screen.dart';
import 'package:whatsapp/feature/authorization/presentation/cubit/authorization_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/feature/nav_screen/navigation_screen.dart';
import 'core/routes/routes_screens.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) =>  getIt<ChatCubit>()..getChats(),
        child: MaterialApp(
          title: 'WhatsApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          onGenerateRoute: RouteGenerator.generateRoute,
          home: const FirstScreen(),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null ?
    BlocProvider(create:
        (context) => getIt<AuthorizationCubit>(),
        child: AuthorizationScreen())
        : BlocProvider(create:
        (context) => NavigationCubit(),
      child: NavigationScreen(),);
  }
}

