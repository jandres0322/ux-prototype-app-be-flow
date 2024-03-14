// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';

class InputCustom extends StatelessWidget {
  final IconData iconData;
  final bool hasIcon;
  final String hintText;
  final TextInputType keyboardType;
  final String labelText;
  final int maxLength;
  final Color colorBorderInput;
  final FormFieldSetter onSaved;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onChanged;
  final double marginHorizontal;
  final TextEditingController controller;
  final void Function()? onPressedIcon;


  const InputCustom({
    super.key,
    required this.hintText,
    this.iconData = Icons.abc,
    this.hasIcon = false,
    required this.keyboardType,
    required this.labelText,
    required this.onSaved,
    required this.validator,
    required this.onChanged,
    this.maxLength = 10,
    this.colorBorderInput = AppColors.primary,
    required this.marginHorizontal,
    required this.controller,
    this.onPressedIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.01,
              top: size.height * 0.01
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labelText,
                style: AppTextStyle.withColor(
                  AppTextStyle.textPlaceholder,
                  colorBorderInput
                )
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          TextFormField(
            scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            maxLength: maxLength,
            onSaved: onSaved,
            decoration: _decorationInput(icon: iconData, hintText: hintText),
            onChanged: onChanged,
            validator: validator,
            controller: controller,
          )
        ]
      )
    );
  }

  InputDecoration _decorationInput(
      {required IconData icon,
      required String hintText,
      Color? iconColor = Colors.black
  }) {
    return InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: colorBorderInput,
            width: 1
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: colorBorderInput,
            width: 1
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.gray60
          )
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.textPlaceholder,
        suffixIcon: _buildIcon(),
      );
  }

  _buildIcon() {
    return hasIcon
    ? IconButton(
          icon: Icon(iconData, color: colorBorderInput),
          onPressed: onPressedIcon,
          disabledColor: AppColors.gray60,
        )
    : null;
  }
}
