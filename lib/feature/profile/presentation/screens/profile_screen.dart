import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/routes/routes_screens.dart';
import 'package:whatsapp/core/theme/app_text_style.dart';
import 'package:whatsapp/core/utils/app_snackBar.dart';
import 'package:whatsapp/core/widgets/custom_button.dart';
import 'package:whatsapp/core/widgets/custom_text_field.dart';
import 'package:whatsapp/core/validators/validators.dart';
import 'package:whatsapp/feature/chat/data/models/user_model.dart';
import 'package:whatsapp/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:whatsapp/feature/profile/presentation/widgets/profile_image_widget.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _imageUrlController;
  late TextEditingController? _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController(
      text: user?.displayName ?? "User Name",
    );
    _emailController = TextEditingController(
      text: user?.email ?? "user@example.com",
    );
    _imageUrlController = TextEditingController(text: user?.photoURL ?? "");
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
      if(state is ProfileSuccess){
      AppSnackBar.showSuccess(context, "Profile updated successfully!");
      Navigator.pushReplacementNamed(context,Routes.navigation);
      }
      if(state is LogoutSuccess){
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.authorization,
              (route) => false,
        );
      }
      },
      child:SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profile', style: AppTextStyle.font24BlackBold),
                  IconButton(
                    onPressed: () async=>
                        await context.read<ProfileCubit>().signOut(),
                    icon: const Icon(Icons.logout, color: Colors.redAccent),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    ProfileImageWidget(imageUrl: _imageUrlController.text),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      label: "Name",
                      controller: _nameController,
                      icon: Icons.person_outline,
                      validator: (value) =>
                          Validators.requiredValidator(value, "Name"),
                    ),
                    SizedBox(height: 20.h),
                    _buildEmailButton(),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      label: "Image URL",
                      controller: _imageUrlController,
                      icon: Icons.link,
                      onChanged: (val) => setState(() {}),
                    ),
                    SizedBox(height: 50.h),
                    CustomButton(
                      text: "Save Changes",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController?.text.trim() == '') {
                            _passwordController = null;
                          }
                          await context.read<ProfileCubit>().updateProfile(
                            user: UserModel(
                              name: _nameController.text,
                              image: _imageUrlController.text,
                              email: _emailController.text,
                            ),
                            password: _passwordController?.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: () async {
            final Map<String, String>? credential =
            await Navigator.pushNamed<Map<String, String>?>(
              context,
              Routes.updateEmail,
              arguments: _emailController.text,
            );

            if (credential != null &&
                credential.isNotEmpty &&
                credential.containsKey('email') &&
                credential.containsKey('password')) {
              setState(() {
                _emailController.text = credential['email'] ?? '';
                _passwordController?.text = credential['password'] ?? '';
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.email_outlined, color: Colors.blue),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _emailController.text,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
