import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/input_custom_widget.dart';

class RegisterNameScreen extends StatefulWidget {
  const RegisterNameScreen({super.key});

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      if (_textController.text.length > 3) {
        setState(() {
          isValid = true;
        });
      } else {
        setState(() {
          isValid = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrate', style: AppTextStyle.titleModals),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.1
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: size.width * 0.37
                  ),
                  child: Text(
                    '¿Como te llamamos?',
                    style: AppTextStyle.withColor(
                      AppTextStyle.textTextsButtons,
                      AppColors.primary
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.044,
                ),
                InputCustom(
                  hintText: 'Ingresa tu nombre',
                  keyboardType: TextInputType.name,
                  labelText: 'Nombre',
                  onSaved: (value) {
                    userDataProvider.nameRegister = value;
                  },
                  validator: (value) {
                      if ( value == null ||  value.length <= 3) {
                        return "El nombre debe ser mayor a 3 caracteres";
                      }
                      return null;
                    },
                  onChanged: (value) {
                    userDataProvider.nameRegister = value;
                   },
                  marginHorizontal: size.width * 0.06,
                  controller: _textController,
                  colorBorderInput: AppColors.primary,
                  maxLength: 20,
                ),
                ButtonCustom(
                    height: size.height * 0.05,
                    width: size.width * 0.7,
                    marginVertical: size.height * 0.03,
                    textButton: 'Siguiente',
                    onPressed: !isValid
                    ? null
                    : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamed(context, 'welcome');
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}