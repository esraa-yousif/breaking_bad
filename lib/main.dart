import 'package:final_project/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'character/character_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  final isLoggedIn = sp.getString('token') != null;
  runApp( MyApp(
    home: isLoggedIn ? CharacterView() : RegisterView(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.home}) : super(key: key);

  final Widget home;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
