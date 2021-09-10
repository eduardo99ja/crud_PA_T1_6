import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_crud/src/pages/home/home_page.dart';
import 'package:my_crud/src/pages/login/login_page.dart';
import 'package:my_crud/src/pages/register/register_page.dart';
import 'package:my_crud/src/utils/colors.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalogo de juegos',
      initialRoute: 'home',
      theme: ThemeData(
          fontFamily: 'NimbusSans',
          appBarTheme: AppBarTheme(elevation: 0),
          primaryColor: utils.Colors.primaryColor),
      routes: {
        'home': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
