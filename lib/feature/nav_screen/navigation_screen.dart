import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/gen/assets.gen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<NavigationCubit,NavigationState>(
        builder: (context, state) => screens[state.index],) ,
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
  builder: (context, state) {
    return BottomNavigationBar(
      onTap: (index) => context.read<NavigationCubit>().navigate(index),
        currentIndex: state.index,
          items:[ BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.statucIcon),label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.inactiveCallIcon),label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.inActiveCameraIcon),label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.chatIcon),label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.icons.settingsIcon),label: ""),]);
  },
),
    );
  }
}
