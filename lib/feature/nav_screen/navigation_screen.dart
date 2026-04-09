import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/gen/assets.gen.dart';

import '../../core/theme/app_colors.dart';

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

          items:[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.statucIcon,colorFilter:
              ColorFilter.mode( state.index==0?AppColors.primaryBlueColor:AppColors.navGreyColor,BlendMode.srcIn),),label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.inactiveCallIcon,colorFilter:
              ColorFilter.mode( state.index==1?AppColors.primaryBlueColor:AppColors.navGreyColor,BlendMode.srcIn),),label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.inActiveCameraIcon,colorFilter:
              ColorFilter.mode( state.index==2?AppColors.primaryBlueColor:AppColors.navGreyColor,BlendMode.srcIn),),label: ""),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.chatIcon,colorFilter:
              ColorFilter.mode( state.index==3?AppColors.primaryBlueColor:AppColors.navGreyColor,BlendMode.srcIn),),label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.icons.settingsIcon,colorFilter:
                ColorFilter.mode( state.index==4?AppColors.primaryBlueColor:AppColors.navGreyColor,BlendMode.srcIn),),label: ""),]);
  },
),
    );
  }
}
