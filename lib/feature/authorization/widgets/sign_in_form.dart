import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_colors.dart';
import 'package:whatsapp/core/theme/app_theme.dart';
import 'package:country_picker/country_picker.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    this.onChanged,
    this.controller,
    required this.onPhoneCodeSelected,
    this.country, this.validators,
  });
  final String? Function(String?)? validators;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final void Function(Country) onPhoneCodeSelected;
  final Country? country;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(),
        TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                country?.name??"United States",
                style: AppTheme.textButtonStyle.copyWith(
                  color: AppColors.primaryBlueColor,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.primaryGreyColor),
            ],
          ),
        ),
        Container(
          height: 1.h,
          width: double.infinity,
          color: AppColors.primaryGreyColor,
        ),

        Row(
          children: [
            TextButton(
              onPressed: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: onPhoneCodeSelected,
                );
              },
              child: Text(
                "+${country?.phoneCode ?? 1}",
                style: TextStyle(
                  fontSize: 27.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 45.h,
              width: 1.w,
              color: AppColors.primaryGreyColor,
            ),
            Expanded(
              child: TextFormField(autovalidateMode: AutovalidateMode.onUnfocus,
                validator: validators,
                keyboardType: TextInputType.number,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: controller,
                onChanged: onChanged,
                style: AppTheme.textPhoneStyle.copyWith(color: Colors.black),
                cursorHeight: 34.h,
                cursorWidth: 2.w,
                cursorColor: AppColors.primaryBlueColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  hintText: "phone number",
                  hintStyle: AppTheme.textPhoneStyle,
                  border: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                 // focusedBorder: InputBorder.none,
                //  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1.h,
          width: double.infinity,
          color: AppColors.primaryGreyColor,
        ),
      ],
    );
  }
}
