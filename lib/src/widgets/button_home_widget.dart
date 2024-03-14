import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';

class ButtonHome extends StatelessWidget {
  const ButtonHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        height: 60,
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.4,
          vertical: size.height * 0.01
        ),
        child: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          icon: SvgPicture.asset('assets/svg/iconHome.svg'),
          onPressed: () {
            // Manejar la navegación aquí si es necesario
          },
        ),
      );
  }
}