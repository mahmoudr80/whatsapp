import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/routes/routes_screens.dart';
import 'package:whatsapp/core/theme/app_color.dart';
import 'package:whatsapp/core/theme/app_text_style.dart';
import 'package:whatsapp/core/utils/app_snackBar.dart';
import 'package:whatsapp/core/widgets/custom_button.dart';
import 'package:whatsapp/feature/authorization/presentation/cubit/authorization_cubit.dart';
import 'package:whatsapp/feature/authorization/presentation/widgets/google_sign_in_button.dart';
import 'package:whatsapp/feature/authorization/presentation/widgets/login_form.dart';
import 'package:whatsapp/feature/authorization/presentation/widgets/registration_form.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();

  // Controllers for Login
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  // Controllers for Registration
  final TextEditingController _regNameController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _regConfirmPasswordController =
      TextEditingController();
  final TextEditingController _regImageUrlController = TextEditingController();

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _regNameController.dispose();
    _regEmailController.dispose();
    _regPasswordController.dispose();
    _regConfirmPasswordController.dispose();
    _regImageUrlController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        if (state is AuthorizationSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.navigation,
            (route) => false,
          );
          AppSnackBar.showSuccess(
            context,
            "${isLogin ? 'Login' : 'Registration'} successful!",
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isLogin ? "Login" : "Register",
            style: AppTextStyle.font24BlackBold,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              autovalidateMode:AutovalidateMode.onUnfocus ,
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    isLogin
                        ? "Welcome back! Please login to your account."
                        : "Create a new account to get started.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 30.h),

                  if (isLogin)
                    LoginForm(
                      emailController: _loginEmailController,
                      passwordController: _loginPasswordController,
                    )
                  else
                    RegistrationForm(
                      nameController: _regNameController,
                      emailController: _regEmailController,
                      passwordController: _regPasswordController,
                      confirmPasswordController: _regConfirmPasswordController,
                      imageUrlController: _regImageUrlController,
                    ),

                  SizedBox(height: 40.h),

                  // Auth Button
                  CustomButton(
                    text: isLogin ? "Login" : "Register",
                    onPressed:() {
                      if(_formKey.currentState?.validate()??false)
                        {
                          isLogin
                              ? login(context)
                          : register(context);
                        }
                    }
                  ),

                  SizedBox(height: 20.h),

                  TextButton(
                    onPressed: _toggleAuthMode,
                    child: Text(
                      isLogin
                          ? "Don't have an account? Register"
                          : "Already have an account? Login",
                      style: const TextStyle(color: AppColor.primaryBlueColor),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  const Text("OR", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20.h),

                  const GoogleSignInButton(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context){
    context.read<AuthorizationCubit>().login(
      email: _loginEmailController.text,
      password: _loginPasswordController.text,
    );
  }
  void register(BuildContext context){
    context.read<AuthorizationCubit>().register(user:
    UserModel(name: _regNameController.text,
        image: _regImageUrlController.text,
        email: _regEmailController.text),
        password:_regPasswordController.text);
  }
}

