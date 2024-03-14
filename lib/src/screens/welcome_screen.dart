
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              left: size.width * 0.005
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.09,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.09
                  ),
                  child: Text(
                    'Bienvenido a BeFlow',
                    style: AppTextStyle.withColor(
                      AppTextStyle.titleModals,
                      AppColors.primary
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: size.width * 0.09
                  ),
                  child: Text(
                    'Iniciemos agregando tus tareas pendientes',
                    style: AppTextStyle.withColor(
                      AppTextStyle.textTextsButtons,
                      AppColors.primary
                    )
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: SizedBox(
                      width: size.width * 0.8,
                      child: Stack(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: _textController,
                            onSaved: (newValue) => { userDataProvider.descriptionNewTask = newValue! },
                            maxLines: 6,
                            decoration: InputDecoration(
                              hintText: "¿Que necesitas hacer?",
                              hintStyle: AppTextStyle.withColor(
                                AppTextStyle.textPlaceholder,
                                AppColors.primary60
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primary
                                )
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primary
                                )
                              )
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shadowColor: AppColors.gray80
                                  ),
                                  icon: const Icon(
                                    Icons.send,
                                    color: AppColors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() && !userDataProvider.disabledButtonCreateTask) {
                                      _formKey.currentState!.save();
                                      final response = userDataProvider.createTask();
                                      if (response) _textController.clear();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Tarea creada correctamente'))
                                      );
                                    }
                                  }
                                ),
                              ],
                            )
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                ),
                Center(
                  child: ButtonCustom(
                    width: size.width * 0.7,
                    height: size.height * 0.05,
                    textButton: "Continuar",
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}