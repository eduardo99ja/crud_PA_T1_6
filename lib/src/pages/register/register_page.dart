import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:my_crud/src/pages/register/register_controller.dart';
import 'package:my_crud/src/utils/colors.dart' as utils;
import 'package:my_crud/src/widgets/button_app.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _con = new RegisterController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _bannerApp(),
            _textRegister(),
            _textFieldUsername(),
            _textFieldEmail(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _buttonRegister(),
          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: ButtonApp(
          onPressed: _con.register,
          text: 'Registrar ahora',
          color: utils.Colors.primaryColor,
          textColor: Colors.white,
        ),
      );

  Widget _textFieldEmail() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          controller: _con.emailController,
          decoration: InputDecoration(
              hintText: 'correo@gmail.com',
              labelText: 'Correo electronico',
              suffixIcon: Icon(
                Icons.email_outlined,
                color: utils.Colors.primaryColor,
              )),
        ),
      );

  Widget _textFieldUsername() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          controller: _con.usernameController,
          decoration: InputDecoration(
              hintText: 'Nombre completo',
              labelText: 'Nombre de usuario',
              suffixIcon: Icon(
                Icons.person_outline,
                color: utils.Colors.primaryColor,
              )),
        ),
      );

  Widget _textFieldPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          obscureText: true,
          controller: _con.passwordController,
          decoration: InputDecoration(
              labelText: 'Contrase??a',
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.Colors.primaryColor,
              )),
        ),
      );

  Widget _textFieldConfirmPassword() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: TextField(
          obscureText: true,
          controller: _con.confirmPasswordController,
          decoration: InputDecoration(
              labelText: 'Confirmar Contrase??a',
              suffixIcon: Icon(
                Icons.lock_open_outlined,
                color: utils.Colors.primaryColor,
              )),
        ),
      );

  Widget _textRegister() => Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          'REGISTRO',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      );

  Widget _bannerApp() => ClipPath(
        clipper: WaveClipperTwo(),
        child: Container(
          color: utils.Colors.primaryColor,
          height: MediaQuery.of(context).size.height * 0.22,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Videojuegos y m??s',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
}
