import 'package:flutter/material.dart';
import 'package:rns_flutter_task/configurations/size_config.dart';
import 'package:rns_flutter_task/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;

  const CustomButton({required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize! * 5,
      width: SizeConfig.defaultSize! * 20,
      decoration: BoxDecoration(
          color: AppColors.appPrimaryBlueColor,
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.defaultSize! * 1))),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 1),
              child: Text(
                buttonText,
                style: TextStyle(
                    color: AppColors.kWhiteColor,
                    fontSize: SizeConfig.defaultSize! * 2,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
