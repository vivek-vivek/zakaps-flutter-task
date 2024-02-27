import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/modules/bottomBar/presentation/screens/bottom_bar_screen.dart';
import 'package:flutter_app/utils/shared_prefrence.dart';

import 'modules/login/presentation/screens/login_screens.dart';

late final Widget firstWidget;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLogin = await SharedPreferencesHelper().getLogin();
  firstWidget = (isLogin == null || isLogin == false)
      ? const LoginScreens()
      : const BottomBarScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: firstWidget,
    );
  }
}
