import 'package:comanda_01/navigation/widgetTree.dart';
import 'package:flutter/material.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final User? user = Auth().currerntUser;

  Future<void> signOut() async {
    try {
      await Auth().signOut();
      print("Usuário deslogado com sucesso.");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WidgetTree()),
        (route) => false,
      );
    } catch (e) {
      print("Erro ao deslogar: $e");
    }
  }

  Widget _userInfo() {
    if (user != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Nome:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Text(
            user?.displayName ?? 'Sem nome disponível',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          Text(
            'Email:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Text(
            user?.email ?? 'Email não disponível',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ],
      );
    } else {
      return const Text(
        'Usuário não autenticado',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
  }

  Widget _signOutBtn() {
    return ElevatedButton(
      onPressed: signOut,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
      child: const Text(
        'Fazer Logout',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ColorPalette().mainColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página do Usuário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userInfo(),
            const SizedBox(height: 40),
            _signOutBtn(),
          ],
        ),
      ),
    );
  }
}
