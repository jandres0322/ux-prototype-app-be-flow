import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/input_custom_widget.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        body: SingleChildScrollView(
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
                  'Iniciar Sesión',
                  style: AppTextStyle.withColor(AppTextStyle.titleModals, AppColors.primary),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InputCustom(
                  labelText: 'Número de telefono',
                  marginHorizontal: size.width * 0.15,
                  validator: (value) {
                    if ( value == null ||  value.length != 10) {
                      return "El número debe contener 10 caracteres";
                    }
                    return null;
                  },
                  onChanged: (value) => userDataProvider.cellPhoneLogin = value,
                  onSaved: ( value ) => userDataProvider.cellPhoneLogin = value ?? '',
                  hintText: 'Número de telefono',
                  iconData: Icons.cancel_outlined,
                  keyboardType: TextInputType.phone,
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
                  onPressed: !isValid
                  ? null
                  : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      bool response = userDataProvider.loginUser();
                      if (response) {
                        Navigator.pushNamed(
                          context,
                          'otp',
                          arguments: {
                            'cellphone': _textController.text,
                            'type': 'login'
                          }
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No hay usuarios registrados')
                        )
                      );
                    }
                  },
                ),
                ButtonCustom(
                  height: size.height * 0.05,
                  width: size.width * 0.7,
                  textButton: 'Ingresar con Google',
                  colorButton: AppColors.white,
                  colorText: AppColors.primary,
                  onPressed: () {},
                  isGoogleIcon: true,
                ),
                SizedBox(height: size.height * 0.1),
                const Divider(
                  color: AppColors.primary,
                ),
                Text.rich(
                  TextSpan(
                    text: '¿No tienes cuenta? ',
                    style: AppTextStyle.textTextsButtons,
                    children: [
                      TextSpan(
                        text: 'Registrate',
                        style: AppTextStyle.textTextsButtons,
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamedAndRemoveUntil(context, 'register', (route) => false);
                        }
                      )
                    ]
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}