import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/widgets/entryField.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMsg = '';
  bool isLogin = true;
  bool isLoading = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Auth().signInWithEmailAndPassword(
        password: _controllerPassword.text,
        email: _controllerEmail.text,
      );
      setState(() {
        errorMsg = '';
      });
    } on FirebaseException catch (erro) {
      setState(() {
        errorMsg = erro.message;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Auth().createUserWithEmailAndPassword(
        password: _controllerPassword.text,
        email: _controllerEmail.text,
        name: _controllerName.text,
      );
      setState(() {
        errorMsg = '';
      });
    } on FirebaseException catch (erro) {
      setState(() {
        errorMsg = erro.message;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _actionTitle(Color color) {
    return Text(
      isLogin ? 'Entre na sua conta' : 'Registrar nova conta',
      style: TextStyle(
        fontSize: 18,
        color: color,
      ),
    );
  }

  Widget _errorMsg() {
    return Text(
      errorMsg == '' ? '' : 'Erro: $errorMsg',
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _submitBtn(Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
      onPressed: isLoading
          ? null
          : (isLogin
              ? signInWithEmailAndPassword
              : createUserWithEmailAndPassword),
      child: Text(
        isLogin ? 'Login' : 'Registrar',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _loginOrRegisterBtn(Color color) {
    return TextButton(
      onPressed: isLoading
          ? null
          : () {
              setState(() {
                isLogin = !isLogin;
                errorMsg = '';
              });
            },
      child: Text(
        isLogin
            ? 'Não tem conta? Registrar-se'
            : 'Já possui conta? Fazer login',
        style: TextStyle(
          color: color,
          decoration: TextDecoration.underline,
          decorationColor: color,
          decorationThickness: 2,
        ),
      ),
    );
  }

  Widget _loadingIndicator(mainColor) {
    return CircularProgressIndicator(
      color: mainColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double paddingHorizontal = screenWidth * 0.05;
    double paddingVertical = screenHeight * 0.18;

    final Color mainColor = ColorPalette().mainColor;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            width: screenWidth * 0.95,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _actionTitle(mainColor),
                if (!isLogin) const SizedBox(height: 10),
                if (!isLogin)
                  EntryField(
                      color: mainColor,
                      title: 'Nome',
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                        size: 30.0,
                        color: mainColor,
                      ),
                      controller: _controllerName),
                const SizedBox(height: 10),
                EntryField(
                    color: mainColor,
                    title: 'Email',
                    icon: FaIcon(
                      FontAwesomeIcons.envelope,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerEmail),
                const SizedBox(height: 10),
                EntryField(
                    color: mainColor,
                    title: 'Senha',
                    icon: FaIcon(
                      FontAwesomeIcons.lock,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerPassword),
                const SizedBox(height: 10),
                _errorMsg(),
                if (isLoading) _loadingIndicator(mainColor),
                _loginOrRegisterBtn(mainColor),
                _submitBtn(mainColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
