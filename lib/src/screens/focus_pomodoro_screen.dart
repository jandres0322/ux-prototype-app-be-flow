import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/app_bar_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_home_widget.dart';

class FocusPomodoroScreen extends StatefulWidget {
  const FocusPomodoroScreen({super.key});

  @override
  State<FocusPomodoroScreen> createState() => _FocusPomodoroScreenState();
}

class _FocusPomodoroScreenState extends State<FocusPomodoroScreen> {
  final TextEditingController textEditingController = TextEditingController();
  UserDataProvider userDataProvider = UserDataProvider();
  static int maxMinutes = 25;
  static int maxSeconds = maxMinutes * 60;
  int totalSeconds = maxSeconds;
  Timer? timer;
  final alarm = AudioPlayer();


  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    userDataProvider = Provider.of<UserDataProvider>(context);
    userDataProvider.isModeFocus = false;
    maxMinutes = userDataProvider.userLogged?.configPomodoro?.focus ?? 0;
    maxSeconds = maxMinutes * 60;
    totalSeconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    maxMinutes = userDataProvider.userLogged?.configPomodoro?.focus ?? 0;
    return Scaffold(
      appBar: AppBarCustom.buildApp(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: userDataProvider.isModeFocus
                      ? null
                      : () {
                          showDialogChooseTasks(
                              context, size, userDataProvider);
                        },
                  child: _buildTimer(),
                ),
              ),
              if (userDataProvider.isModeFocus)
                SizedBox(
                  height: size.height * 0.04,
                ),
              if (userDataProvider.isModeFocus)
                ButtonCustom(
                    width: size.width * 0.5,
                    height: size.height * 0.05,
                    textButton: 'Terminar Pomodoro',
                    onPressed: () {
                      timer?.cancel();
                      showDialogAlarm(context);
                    }),
              SizedBox(height: size.height * 0.03),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.primary20),
                height: size.height * 0.4,
                margin: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  top: size.height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.06, top: size.height * 0.03),
                      child: Text(
                        userDataProvider.isModeFocus
                            ? 'Pendientes en curso'
                            : 'Lista de pendientes',
                        style: AppTextStyle.withColor(
                            AppTextStyle.titleListTasks, AppColors.primary),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.03,
                        top: size.height * 0.02,
                      ),
                      height: size.height * 0.3,
                      child: ListView.builder(
                        itemCount: userDataProvider.isModeFocus
                            ? userDataProvider.getTaskOnPomodoro().length
                            : userDataProvider.userLogged?.tasks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                userDataProvider.isModeFocus
                                    ? userDataProvider
                                        .getTaskOnPomodoro()[index]
                                        .description
                                    : userDataProvider
                                        .userLogged!.tasks[index].description,
                                style: AppTextStyle.textBodyListTasks),
                            trailing: const Icon(Icons.double_arrow_rounded,
                                size: 14, color: AppColors.primary),
                            leading: const Icon(Icons.circle,
                                size: 8, color: AppColors.primary),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: userDataProvider.isModeFocus
          ? Container()
          : buildFloatingActionButton(size, context, userDataProvider),
      bottomNavigationBar: const ButtonHome(),
    );
  }

  Future<dynamic> showDialogAlarm(
    BuildContext context
  ) {
    final Size size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.primary,
              width: 2
            ),
            borderRadius: BorderRadius.circular(20.0)
          ),
          title: Text(
            'Alarma',
            style: AppTextStyle.withColor(
              AppTextStyle.titleModals,
              AppColors.primary
            ),
          ),
          content: Text(
            '!Objetivo logrado!',
            style: AppTextStyle.withColor(
              AppTextStyle.textTextsButtons,
              AppColors.primary
            )
          ),
          actions: [
            Center(
              child: ButtonCustom(
                width: size.width * 0.5,
                height: size.height * 0.05,
                textButton: "Continuar",
                onPressed: () {
                  deactivateAlarm();
                  Navigator.pushNamed(context, 'home');
                }
              ),
            )
          ],
        );
      }
    );
  }

  Future<dynamic> showDialogChooseTasks(
      BuildContext context, Size size, UserDataProvider userDataProvider) {
    return showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: AppColors.backgroundPurple,
              titlePadding: EdgeInsets.zero,
              titleTextStyle: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppColors.primary),
              title: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Seleccionar Pendientes'),
                    IconButton(
                      icon: const Icon(Icons.cancel_outlined,
                          color: AppColors.primary),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              content: SizedBox(
                height: size.height * 0.6,
                child: Column(
                  children: [
                    Text(
                      'Selecciona las tareas trabajar en el ciclo',
                      style: AppTextStyle.textBodyListTasks,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: AppColors.white),
                      height: size.height * 0.45,
                      width: size.width * 0.7,
                      margin: EdgeInsets.only(
                        left: size.width * 0.01,
                        right: size.width * 0.01,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: size.height * 0.03,
                                right: size.width * 0.15),
                            child: Text(
                              'Lista de pendientes',
                              style: AppTextStyle.withColor(
                                  AppTextStyle.titleListTasks,
                                  AppColors.primary),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: size.width * 0.03,
                              top: size.height * 0.02,
                            ),
                            height: size.height * 0.35,
                            child: ListView.builder(
                              itemCount:
                                  userDataProvider.userLogged!.tasks.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: userDataProvider.userLogged!
                                          .tasks[index].isPomodoroActual
                                      ? AppColors.primary20
                                      : AppColors.white,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.white,
                                  child: ListTile(
                                    style: ListTileStyle.list,
                                    title: Text(
                                        userDataProvider.userLogged!
                                            .tasks[index].description,
                                        style: AppTextStyle.textBodyListTasks),
                                    trailing: const Icon(
                                        Icons.double_arrow_rounded,
                                        size: 14,
                                        color: AppColors.primary),
                                    leading: const Icon(Icons.circle,
                                        size: 8, color: AppColors.primary),
                                    onTap: () {
                                      setState(() {
                                        userDataProvider.userLogged!
                                                .tasks[index].isPomodoroActual =
                                            !userDataProvider.userLogged!
                                                .tasks[index].isPomodoroActual;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ButtonCustom(
                        width: size.width * 0.7,
                        height: size.height * 0.05,
                        textButton: "Iniciar ahora",
                        onPressed: () {
                          setState(() {
                            userDataProvider.isModeFocus = true;
                            Navigator.pop(context);
                            startTimer();
                          });
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  Row buildFloatingActionButton(
      Size size, BuildContext context, UserDataProvider userDataProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.25),
            FloatingActionButton(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: const BorderSide(
                    width: 1,
                    color: AppColors.primary,
                  )),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        backgroundColor: AppColors.backgroundPurple,
                        titlePadding: EdgeInsets.zero,
                        titleTextStyle: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: AppColors.primary),
                        title: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Agregar Pendientes'),
                              IconButton(
                                icon: const Icon(Icons.cancel_outlined,
                                    color: AppColors.primary),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                        content: SizedBox(
                          height: size.height * 0.3,
                          child: Column(
                            children: [
                              Text('Ingresa el pendiente que quieres agregar',
                                  style: AppTextStyle.textBodyListTasks),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: textEditingController,
                                onChanged: (newValue) => {
                                  userDataProvider.descriptionNewTask = newValue
                                },
                                maxLines: 6,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.white,
                                    hintText: "¿Que necesitas hacer?",
                                    hintStyle: AppTextStyle.withColor(
                                        AppTextStyle.textPlaceholder,
                                        AppColors.primary60),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.primary)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.primary))),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              ButtonCustom(
                                  width: size.width * 0.7,
                                  height: size.height * 0.05,
                                  textButton: "Agregar pendiente",
                                  onPressed: () {
                                    final response =
                                        userDataProvider.createTask();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Tarea creada correctamente')));
                                  })
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: const Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        SizedBox(width: size.width * 0.03)
      ],
    );
  }

  Widget _buildTimer() => Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.pomodoro50,
            borderRadius: BorderRadius.circular(200.0)),
        child: Stack(fit: StackFit.expand, children: [
          CircularProgressIndicator(
            value: 1 - totalSeconds / maxSeconds,
            strokeWidth: 12,
            valueColor: const AlwaysStoppedAnimation(AppColors.filledPomodoro),
            backgroundColor: AppColors.primary,
          ),
          Center(child: _buildTime())
        ]),
      );

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (totalSeconds > 0) {
        setState(() => totalSeconds--);
      } else {
        activateAlarm();
        showDialogAlarm(context);
        timer?.cancel();
      }
    });
  }

  void activateAlarm() async {
    await alarm.setAsset('assets/audios/alarm.mp3');
    alarm.play();
  }

  void deactivateAlarm() async {
    alarm.stop();
  }

  Widget _buildTime() {
    return Text(
      formatTimer(totalSeconds),
      style:
          AppTextStyle.withColor(AppTextStyle.numberTempo, AppColors.primary),
    );
  }

  String formatTimer(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  void dispose() {
    textEditingController.dispose();
    alarm.stop();

    if (timer != null) {
      timer!.cancel();
    }

    super.dispose();
  }
}
