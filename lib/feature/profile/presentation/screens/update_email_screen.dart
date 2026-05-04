import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_text_style.dart';
import 'package:whatsapp/core/validators/validators.dart';
import 'package:whatsapp/core/widgets/custom_button.dart';
import 'package:whatsapp/core/widgets/custom_text_field.dart';

class UpdateEmailScreen extends StatefulWidget {
  final String oldEmail;

  const UpdateEmailScreen({super.key, required this.oldEmail});

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _oldEmailController;
  late TextEditingController _newEmailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _oldEmailController = TextEditingController();
    _newEmailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldEmailController.dispose();
    _newEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () =>Navigator.pop(context) ,
            icon:Icon(Icons.arrow_back)),
        title: Text('Change Email',
            style: AppTextStyle.font24BlackBold.copyWith(fontSize: 20.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Text(
                "Verify your current email and set a new one.",
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                label: "Current Email",
                controller: _oldEmailController,
                icon: Icons.email_outlined,
                hintText: "Verify current email",
                validator: (value) {
                  if (value != widget.oldEmail) {
                    return "Incorrect current email";
                  }
                  return Validators.emailValidator(value);
                },
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                label: "New Email",
                controller: _newEmailController,
                icon: Icons.mark_email_read_outlined,
                validator: (value) => Validators.emailValidator(value),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                label: "Password",
                controller: _passwordController,
                icon: Icons.lock_outline,
                isPassword: true,
                validator: (value) => Validators.passwordValidator(value),
              ),
              SizedBox(height: 50.h),
              CustomButton(
                text: "Update Email",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context,{
                      'email':_newEmailController.text,
                      'password':_passwordController.text
                    } );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
