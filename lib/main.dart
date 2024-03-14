import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ux_prototype_app_be_flow/src/app.dart';
import 'package:ux_prototype_app_be_flow/src/providers/user_data_provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider())
      ],
      child: const App(),
    );
  }
}