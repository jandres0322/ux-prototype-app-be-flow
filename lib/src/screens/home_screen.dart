import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/text_style.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/app_bar_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_custom_widget.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/button_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final size = MediaQuery.of(context).size;
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarCustom.buildApp(context) ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: AppColors.primary20
              ),
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
                      left: size.width * 0.06,
                      top: size.height * 0.03
                    ),
                    child: Text(
                       'Lista de pendientes',
                      style: AppTextStyle.withColor(
                        AppTextStyle.titleListTasks,
                        AppColors.primary
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * 0.03,
                      top: size.height * 0.02,
                    ),
                    height: size.height * 0.3,
                    child: ListView.builder(
                      itemCount: userDataProvider.userLogged?.tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            userDataProvider.userLogged?.tasks[index].description ?? '',
                            style: AppTextStyle.textBodyListTasks
                          ),
                          trailing: const Icon(
                            Icons.double_arrow_rounded,
                            size: 14,
                            color: AppColors.primary
                          ),
                          leading: const Icon(
                            Icons.circle,
                            size: 8,
                            color: AppColors.primary
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            ButtonCustom(
              width: size.width * 0.7,
              height: size.height * 0.05,
              textButton: 'Iniciar mi trabajo',
              onPressed: () {
                Navigator.pushNamed(context, 'setup_pomodoro');
              }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
          side: const BorderSide(
            width: 1,
            color: AppColors.primary,
          )
        ),
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
                  color: AppColors.primary
                ),
                title: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Agregar Pendientes'),
                      IconButton(
                        icon: const Icon( Icons.cancel_outlined, color: AppColors.primary ),
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
                      Text(
                        'Ingresa el pendiente que quieres agregar',
                        style: AppTextStyle.textBodyListTasks
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: textEditingController,
                        onChanged: (newValue) => { userDataProvider.descriptionNewTask = newValue },
                        maxLines: 6,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
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
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      ButtonCustom(
                        width: size.width * 0.7,
                        height: size.height * 0.05,
                        textButton: "Agregar pendiente",
                        onPressed: () {
                            final response = userDataProvider.createTask();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tarea creada correctamente'))
                            );
                        }
                      )
                    ],
                  ),
                ),
              );
            }
          );
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      bottomNavigationBar: const ButtonHome(),
    );
  }
}