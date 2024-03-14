import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final OtpFieldController _controller = OtpFieldController();
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.01
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Introduce el código de 6 digitos',
                    style: AppTextStyle.withColor(AppTextStyle.textTextsButtons, AppColors.primary),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  OTPTextField(
                    length: 6,
                    width: size.width * 0.65,
                    fieldWidth: size.width * 0.1,
                    controller: _controller,
                    fieldStyle: FieldStyle.box,
                    style: AppTextStyle.titleModals,
                    otpFieldStyle: OtpFieldStyle(
                      enabledBorderColor: AppColors.primary10,
                      focusBorderColor: AppColors.primary,
                      backgroundColor: AppColors.secondary50,
                    ),
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    onCompleted: (value) {
                      RegExp regex = RegExp(r'^[0-9]+$');
                      if (regex.hasMatch(value)) {
                        isValid = true;
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    'Tu código se envió a +57 ${arguments['cellphone']}',
                    style: AppTextStyle.withColor(AppTextStyle.textTextsButtons, AppColors.primary),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  ButtonCustom(
                    width: size.width * 0.7,
                    height: size.height * 0.05,
                    textButton: "Volver a enviar código",
                    colorButton: AppColors.white,
                    colorText: AppColors.primary,
                    onPressed: () {}
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  ButtonCustom(
                    width: size.width * 0.7,
                    height: size.height * 0.05,
                    textButton: "Ingresar",
                    colorButton: AppColors.primary,
                    colorText: AppColors.white,
                    onPressed: !isValid
                    ? null
                    : () {
                      final String type = arguments['type'];
                      Navigator.pushNamedAndRemoveUntil(context, type == 'login' ? 'home' : 'register_name', (route) => false);
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}