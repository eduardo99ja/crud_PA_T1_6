import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_crud/src/models/user.dart';
import 'package:my_crud/src/providers/auth_provider.dart';
import 'package:ndialog/ndialog.dart';

class LoginController {
  late BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  late AuthProvider _authProvider;

  Future init(BuildContext context) async {
    this.context = context;
    _authProvider = new AuthProvider();
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    ProgressDialog _progressDialog = ProgressDialog(context,
        message: Text("Por favor, espere un momento"), title: Text("Cargando"));
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty && password.isEmpty) {
      final snackBar =
          SnackBar(content: Text('Debes ingresar sus credenciales'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    _progressDialog.show();

    try {
      bool isLogin = await _authProvider.login(email, password);
      _progressDialog.dismiss();

      if (isLogin) {
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
        print('El usuario esta logeado');
      }
    } catch (error) {
      _progressDialog.dismiss();
      final snackBar = SnackBar(content: Text('Error: $error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
