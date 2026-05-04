import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/widgets/custom_text_field.dart';

import '../../../../core/validators/validators.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Email",
          controller: emailController,
          icon: Icons.email_outlined,
          validator: (value) => Validators.emailValidator(value),
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          label: "Password",
          controller: passwordController,
          icon: Icons.lock_outline,
          isPassword: true,
          validator: (value) => Validators.passwordValidator(value),
        ),
      ],
    );
  }
}
