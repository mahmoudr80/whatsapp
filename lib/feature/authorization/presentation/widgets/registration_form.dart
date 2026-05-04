import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/widgets/custom_text_field.dart';

import '../../../../core/validators/validators.dart';

class RegistrationForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController imageUrlController;

  const RegistrationForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.imageUrlController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Name",
          controller: nameController,
          icon: Icons.person_outline,
          validator: (value) => Validators.requiredValidator(value, "Name"),
        ),
        SizedBox(height: 15.h),
        CustomTextField(
          label: "Email",
          controller: emailController,
          icon: Icons.email_outlined,
          validator: (value) => Validators.emailValidator(value),
        ),
        SizedBox(height: 15.h),
        CustomTextField(
          label: "Password",
          controller: passwordController,
          icon: Icons.lock_outline,
          isPassword: true,
          validator: (value) => Validators.passwordValidator(value),
        ),
        SizedBox(height: 15.h),
        CustomTextField(
          label: "Confirm Password",
          controller: confirmPasswordController,
          icon: Icons.lock_clock_outlined,
          isPassword: true,
          validator: (value) {
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return Validators.passwordValidator(value);
          },
        ),
        SizedBox(height: 15.h),
        CustomTextField(
          label: "Image URL",
          controller: imageUrlController,
          icon: Icons.link,
        ),
      ],
    );
  }
}
