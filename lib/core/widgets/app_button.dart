
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key, this.tapped,
  });
final void Function()?tapped;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:tapped,
        style: ButtonStyle(
            backgroundColor:WidgetStateProperty.resolveWith((states) {
              return Colors.transparent;
            },),
            overlayColor: null,elevation:null,  shadowColor: WidgetStateProperty.all(Colors.transparent),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if(states.contains(WidgetState.disabled)){
                return AppColors.primaryGreyColor;
              }
              else if(states.contains(WidgetState.pressed)){
                return AppColors.primaryPurpleColor;
              }
              return AppColors.PrimaryBlueColor;
            },)),
        child:Text("data",style: TextStyle(fontSize: 17.sp),)

    );
  }
}
