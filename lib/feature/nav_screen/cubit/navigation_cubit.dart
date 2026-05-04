import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/core/di/dependency_injection.dart';
import 'package:whatsapp/feature/chat/presentation/cubit/chat_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/screens/chat_list_screen.dart';
import 'package:whatsapp/feature/profile/presentation/cubit/profile_cubit.dart';

import '../../profile/presentation/screens/profile_screen.dart';

part 'navigation_state.dart';

final List<Widget> screens = [
  BlocProvider(
    create: (context) => getIt<ChatCubit>(),
    child: const ChatListScreen(),
  ),
  BlocProvider(create:
  (context)=>getIt<ProfileCubit>(),child: const ProfileScreen()),
];

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  void navigate(int index) {
    if(isClosed){return;}
    emit(NavigationUpdate(index));
  }
}
