import 'package:flutter/material.dart';
import 'package:comanda_01/services/auth.dart';
import 'package:comanda_01/widgets/mainActionsList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currerntUser;

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Corpo da tela
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Adicionando um SizedBox para espaçar a lista do topo
                SizedBox(height: 125), // Ajuste esse valor conforme necessário
                MainActionsList(),
              ],
            ),
          ),

          // Botão no canto esquerdo (sem círculo)
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.user,
                size: 60.0,
                color: mainColor,
              ), // Aumentando o tamanho do ícone
              onPressed: () {
                Navigator.pushNamed(context, 'userPage');
              },
            ),
          ),

          // Botão no canto direito (ícone de sino)
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bell,
                size: 60.0,
                color: mainColor,
              ), // Aumentando o tamanho do ícone
              onPressed: () {
                // Ação do botão direito
                print('Botão direito (sino) pressionado');
              },
            ),
          ),
        ],
      ),
    );
  }
}
