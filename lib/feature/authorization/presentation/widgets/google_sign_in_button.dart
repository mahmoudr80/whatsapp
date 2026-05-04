import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/app.dart';
import 'package:whatsapp/core/theme/app_theme.dart';
import 'package:whatsapp/feature/authorization/data/datasource/auth_remote_datasource.dart';
import 'package:whatsapp/feature/authorization/data/repository/auth_repo.dart';
import 'package:whatsapp/core/routes/routes_screens.dart';
import 'package:whatsapp/feature/authorization/presentation/cubit/authorization_cubit.dart';
import 'package:whatsapp/gen/assets.gen.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
              side: BorderSide(color: Colors.black26.withAlpha(40))),
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: InkWell(
            onTap: () async {
              try {
                await context.read<AuthorizationCubit>().signInWithGoogle();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.navigation,
                  (route) => false,
                );
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 4,
                      offset: const Offset(0, 3),
                      blurRadius: 4)
                ]),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10.w,
                  children: [
                    SvgPicture.asset(Assets.icons.googleIcon),
                    Text(
                      "Sign in with google",
                      style: AppTheme.textButtonStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
