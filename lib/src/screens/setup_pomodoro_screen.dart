import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/models/config_pomodoro.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/app_bar_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';

class SetupPomodoroScreen extends StatefulWidget {
  const SetupPomodoroScreen({super.key});

  @override
  State<SetupPomodoroScreen> createState() => _SetupPomodoroScreenState();
}

class _SetupPomodoroScreenState extends State<SetupPomodoroScreen> {

  final TextEditingController focusTimeController = TextEditingController();
  final TextEditingController breakTimeController = TextEditingController();
  final TextEditingController longBreakController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final ConfigPomodoro? configPomodoro = userDataProvider.userLogged?.configPomodoro;
    return Scaffold(
      appBar: AppBarCustom.buildApp(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                'Configura tus ciclos de Pomodoro',
                style: AppTextStyle.withColor(
                  AppTextStyle.titleListTasks,
                  AppColors.primary
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                'Duración en minutos',
                style: AppTextStyle.withColor(
                  AppTextStyle.textPlaceholder,
                  AppColors.primary
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    _createInputSetupPomodoro(
                      controller: focusTimeController,
                      initialValue: configPomodoro?.focus.toString() ?? "25",
                      size: size,
                      label: 'Focus'
                    ),
                    _createInputSetupPomodoro(
                      controller: breakTimeController,
                      initialValue: configPomodoro?.configPomodoroBreak.toString() ?? "5",
                      size: size,
                      label: 'Break'
                    ),
                    _createInputSetupPomodoro(
                      controller: longBreakController,
                      initialValue: configPomodoro?.focus.toString() ??  "15",
                      size: size,
                      label: 'Long Break'
                    ),
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              ButtonCustom(
                width: size.width * 0.7,
                height: size.height * 0.05,
                textButton: 'Continuar',
                onPressed: () {
                  userDataProvider.createConfigPomodoro(
                    focusTimeController.text,
                    breakTimeController.text,
                    longBreakController.text
                  );
                  Navigator.pushNamed(context, 'focus_pomodoro');
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createInputSetupPomodoro({
    required String initialValue,
    required Size size,
    required TextEditingController controller,
    required String label
  }) {
    if (controller.text.isEmpty) {
      controller.text = initialValue;
    }
    return Column(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              int currentValue = int.tryParse(controller.text) ?? 0;
              controller.text = ( currentValue + 1 ).toString();
            });
          },
          icon: const Icon(Icons.arrow_drop_up_outlined, color: AppColors.pomodoro,)
        ),
        SizedBox(
          height: size.height * 0.1,
          width: size.width * 0.2,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: AppTextStyle.withColor(
              AppTextStyle.numberConfigPomodoro,
              AppColors.primary
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primary10,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.pomodoro10
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.pomodoro10
                )
              )
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              int currentValue = int.tryParse(controller.text) ?? 0;
              if (currentValue > 0 ) {
                controller.text = (currentValue - 1).toString();
              }
            });
          },
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.pomodoro)
        ),
        Text(label, style: AppTextStyle.textTextsButtons)
      ],
    );
  }
}