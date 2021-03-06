import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tlaco_point/services/user/logInService.dart';

import 'package:tlaco_point/src/pages/home_pages/home_page.dart';
import 'package:tlaco_point/src/pages/log_in/signup.dart';

import 'package:tlaco_point/utils/utils.dart';

class LogIn extends StatefulWidget {
  static const String routeName = 'LogIn';
  _Entrar createState() => _Entrar();
}

class _Entrar extends State<LogIn> {
  TextEditingController _emailController;
  TextEditingController _controllerPassword;

  @override
  void initState() {
    super.initState();

    _emailController = new TextEditingController();
    _controllerPassword = new TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _logo(size),
            SizedBox(height: size.height * .05),
            _inputs(size),
            _botonAcceder(context),
            SizedBox(height: size.height * .025),
            _opciones(size),
          ],
        ),
      ),
      bottomNavigationBar: _footer(context),
    );
  }

  Widget _logo(Size size) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Image.asset(
        'assets/TlacoPoint.png',
        width: 300.0,
        height: size.height * 0.30,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  Widget _inputs(Size size) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * .025),
        child: Column(
          children: [
            _inputEmail(size),
            SizedBox(height: size.height * .025),
            _inputPassword(size),
          ],
        ),
      ),
    );
  }

  Widget _inputEmail(Size size) {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget _inputPassword(Size size) {
    return TextField(
      controller: _controllerPassword,
      obscureText: true, //oculta el texto
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  Widget _botonAcceder(BuildContext context) {
    return Hero(
      tag: SignUp.routeName,
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () async {
            bool comprobar = await _verificarUsuario(
                vEmail: _emailController.text,
                vPassword: _controllerPassword.text);
            if (comprobar) {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            } else {
              mostrarDialog(
                  context: context,
                  title: 'ERROR',
                  content: 'Correo/contraseña invalidos');
            }
          },
          child: Text('Acceder', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  Widget _opciones(Size size) {
    return Column(
      children: [
        Text(
          '- O accede usando -',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * .025),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _botonOpcion(
              height: size.height * .07,
              width: size.width * .45,
              label: Text('Facebook'),
              icon: FaIcon(FontAwesomeIcons.facebook),
              backgroundColor: Color.fromRGBO(66, 103, 178, 1),
              onPressed: () {},
            ),
            _botonOpcion(
              height: size.height * .07,
              width: size.width * .45,
              label: Text('Google'),
              icon: FaIcon(FontAwesomeIcons.google),
              backgroundColor: Color.fromRGBO(219, 68, 55, 1),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _botonOpcion(
      {double width,
      double height,
      @required Widget label,
      @required Widget icon,
      Color backgroundColor,
      Function onPressed}) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        label: label,
        icon: icon,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor)),
        onPressed: onPressed,
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No tienes una cuenta?'),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, SignUp.routeName),
            child: Text('Registrate'),
          ),
        ],
      ),
    );
  }
}

_verificarUsuario({
  String vEmail,
  String vPassword,
}) async {
  bool verificado =
      await LogInService.verificar(vEmail: vEmail, vPassword: vPassword);
  return verificado;
}
