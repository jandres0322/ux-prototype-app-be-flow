import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';

class AppBarCustom {
  static AppBar buildApp(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    return AppBar(
      centerTitle: true,
      title: ButtonCustom(
        colorButtonDisabled: AppColors.pomodoro,
        colorTextDisabled: AppColors.primary,
        colorBorder: AppColors.pomodoro,
        width: size.width * 0.5,
        height: size.height * 0.05,
        textButton: "Pomodoro",
        onPressed: null,
        isButtonTitle: true,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
            userDataProvider.logoutUser();
          },
          icon: const Icon(
            Icons.logout,
            color: AppColors.primary,
            size: 30,
          )
        )
      ],
    );
  }
}
