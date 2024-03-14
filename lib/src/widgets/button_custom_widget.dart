import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';

class ButtonCustom extends StatelessWidget {

  final double width;
  final double height;
  final double marginVertical;
  final double marginHorizontal;
  final Color colorButton;
  final Color colorBorder;
  final String textButton;
  final Color colorText;
  final bool isGoogleIcon;
  final IconData iconData;
  final void Function()? onPressed;
  final Color colorButtonDisabled;
  final Color colorTextDisabled;
  final bool isButtonTitle;

  const ButtonCustom({
    super.key,
    required this.width,
    required this.height,
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    required this.textButton,
    this.colorText = AppColors.white,
    this.isGoogleIcon = false,
    this.iconData = Icons.abc,
    required this.onPressed,
    this.colorButton = AppColors.primary,
    this.colorBorder = AppColors.primary,
    this.colorButtonDisabled = AppColors.white,
    this.colorTextDisabled = AppColors.primary,
    this.isButtonTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton,
          foregroundColor: colorText,
          disabledBackgroundColor: colorButtonDisabled,
          disabledForegroundColor: colorTextDisabled,
          surfaceTintColor: AppColors.white,
          side: BorderSide(
            color: colorBorder
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isGoogleIcon)
              SvgPicture.asset('assets/svg/googleLogo.svg'),
              const SizedBox(
                width: 10.0,
              ),
            Text(
              textButton,
              style: isButtonTitle ? AppTextStyle.titleListTasks :  AppTextStyle.textTextsButtons
            )
          ],
        ),
      ),
    );
  }

}