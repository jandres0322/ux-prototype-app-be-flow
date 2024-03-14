import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/input_custom_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      if (_textController.text.length != 10) {
        setState(() {
          isValid = false;
        });
      } else {
        setState(() {
          isValid = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Image(
                    image: AssetImage('assets/images/logo-beflow.png')
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    'Regístrate',
                    style: AppTextStyle.withColor(AppTextStyle.titleModals, AppColors.primary),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ButtonCustom(
                    height: size.height * 0.05,
                    width: size.width * 0.7,
                    textButton: 'Registrar con Google',
                    colorButton: AppColors.white,
                    colorText: AppColors.primary,
                    onPressed: () {},
                    isGoogleIcon: true,
                  ),
                  SizedBox(height: size.height * 0.05),
                  InputCustom(
                    labelText: 'Número de telefono',
                    hintText: 'Número de telefono',
                    iconData: Icons.cancel_outlined,
                    keyboardType: TextInputType.phone,
                    onSaved: (value) { userDataProvider.cellPhoneRegister = value; },
                    validator: (value) {
                      if ( value == null ||  value.length != 10) {
                        return "El número debe contener 10 caracteres";
                      }
                      return null;
                    },
                    onChanged: (value) {},
                    marginHorizontal: size.height * 0.07,
                    controller: _textController,
                    hasIcon: true,
                    onPressedIcon: () {
                      _textController.clear();
                    },
                  ),
                  ButtonCustom(
                    height: size.height * 0.05,
                    width: size.width * 0.7,
                    marginVertical: size.height * 0.03,
                    textButton: 'Enviar Codigo',
                    onPressed:  !isValid
                      ? null
                      : () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bool response = userDataProvider.registerUser();
                          if (response) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'otp',
                              (route) => false,
                              arguments: {
                                'cellphone': _textController.text,
                                'type': 'register'
                              }
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No se pudo crear el usuario'))
                            );
                          }
                        }
                      }
                  ),
                  SizedBox(height: size.height * 0.05),
                  const Divider(),
                  Text.rich(
                    TextSpan(
                      text: '¿Ya tienes una cuenta? ',
                      style: AppTextStyle.textTextsButtons,
                      children: [
                        TextSpan(
                          text: 'Inicia Sesión',
                          style: AppTextStyle.textTextsButtons,
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, 'login');
                          }
                        )
                      ]
                    )
                  )
                ],
              ),
            ),
          )
        )
      )
    );
  }
}