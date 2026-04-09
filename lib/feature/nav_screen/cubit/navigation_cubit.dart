import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/feature/call/data/repository/calls_repository_impl.dart';
import 'package:whatsapp/feature/call/presentation/calls_screen.dart';
import 'package:whatsapp/feature/call/presentation/cubit/call_cubit.dart';
import 'package:whatsapp/feature/chat/presentation/chat_screen.dart';

part 'navigation_state.dart';

final List<Widget>screens = [Placeholder(), BlocProvider(
  create: (context) => CallCubit(CallsRepositoryImpl())..getCalls(0),
  child: CallScreen(),
), Placeholder(), ChatScreen(), Placeholder()];

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  void navigate(int index) {
    emit(NavigationUpdate(index));
  }
}
