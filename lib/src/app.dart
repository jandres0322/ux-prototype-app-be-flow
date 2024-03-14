import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ux_prototype_app_be_flow/src/constants/colors.dart';
import 'package:ux_prototype_app_be_flow/src/constants/routes.dart';
import 'package:ux_prototype_app_be_flow/src/widgets/screen_size_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    log('Running application');
    return LayoutBuilder(builder: ((context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ScreenSize().init(constraints, orientation);
        return ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(360, 780),
          builder: (context, widget) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown
            ]);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: RoutesApp.routes,
              initialRoute: 'login',
              theme: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: AppColors.primary
                )
              ),
              builder: (context, widget) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                  Widget error = Text('... Renderizando error... ${errorDetails.summary}' );
                  if (widget is Scaffold || widget is Navigator) {
                    error = Scaffold(body: Center(child: error));
                  }
                  return error;
                };
                return widget!;
              },
            );
          },
        );
      });
    }));
  }
}