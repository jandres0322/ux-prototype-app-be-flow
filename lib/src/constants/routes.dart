import 'package:flutter/material.dart';
import 'package:ux_prototype_app_be_flow/src/screens/focus_pomodoro_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/home_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/setup_pomodoro_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/login_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/otp_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/register_name_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/register_screen.dart';
import 'package:ux_prototype_app_be_flow/src/screens/welcome_screen.dart';

class RoutesApp {
  static Map<String, WidgetBuilder> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'register': (BuildContext context) => const RegisterScreen(),
    'otp': (BuildContext context) => const OtpScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'register_name': (BuildContext context) => const RegisterNameScreen(),
    'welcome': (BuildContext context) => const WelcomeScreen(),
    'setup_pomodoro': (BuildContext context) => const SetupPomodoroScreen(),
    'focus_pomodoro': (BuildContext context) => const FocusPomodoroScreen()
  };
}