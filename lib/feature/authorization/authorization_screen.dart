import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp/core/theme/app_colors.dart';
import 'package:whatsapp/core/theme/app_theme.dart';
import 'package:whatsapp/feature/authorization/widgets/sign_in_form.dart';
import 'package:country_picker/country_picker.dart';
import '../../core/validators/validators.dart';
import '../../core/widgets/app_button.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {

    TextEditingController? phoneController;
  Country ?country;
  void onPhoneCodeSelected(Country newCountry){
setState(() {
  country=newCountry;
});
}

  void phoneNumberOnChange(String number){

  }
  void signIn(){}
@override
  void initState() {
   phoneController = TextEditingController();
    super.initState();
  }
    String? phoneValidator(String?value){
    String ? currentValue=Validators.phoneValidator("${country?.phoneCode}$value");
    if(currentValue==null){
      setState(() {

      });
      return currentValue;
    }
    else{
      return currentValue;
    }
    }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navBarBackColor,
        centerTitle: true,
        title: Text("Phone number",style: AppTheme.titleTextStyle,),
        actions: [
          AppButton(tapped: phoneController!=null&&Validators.phoneValidator("${country?.phoneCode}${phoneController!.text}")==null?signIn:null,),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 19.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 37.w),
            child: Text('Please confirm your country code and enter your phone number ',
            textAlign: TextAlign.center,
            style: AppTheme.messageTextStyle,),
          ),
          SizedBox(height: 19.h,),
          SignInForm(controller: phoneController,onPhoneCodeSelected:onPhoneCodeSelected ,
            country: country,validators: phoneValidator,)
        ],
      ),
    );


    }
}
