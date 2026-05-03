import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/core/theme/app_color.dart';
import 'package:whatsapp/feature/nav_screen/cubit/navigation_cubit.dart';
import 'package:whatsapp/gen/assets.gen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (index) => context.read<NavigationCubit>().navigate(index),
          currentIndex: state.index,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.icons.chatIcon,
                  colorFilter: ColorFilter.mode(
                      state.index == 0
                          ? AppColor.primaryBlueColor
                          : AppColor.navGreyColor,
                      BlendMode.srcIn),
                ),
                label: "Chats"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.icons.settingsIcon,
                  colorFilter: ColorFilter.mode(
                      state.index == 1
                          ? AppColor.primaryBlueColor
                          : AppColor.navGreyColor,
                      BlendMode.srcIn),
                ),
                label: "Profile"),
          ],
        );
      },
    );
  }
}
