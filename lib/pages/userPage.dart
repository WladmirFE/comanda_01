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

  // Função para sair da conta e redirecionar para a página de login
  Future<void> signOut() async {
    try {
      await Auth().signOut();
      print("Usuário deslogado com sucesso.");

      // Garante que o WidgetTree gerencie o estado após o logout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WidgetTree()),
        (route) => false, // Remove todas as rotas da pilha
      );
    } catch (e) {
      print("Erro ao deslogar: $e");
    }
  }

  // Exibir o nome e e-mail do usuário
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

  // Botão de logout
  Widget _signOutBtn() {
    return ElevatedButton(
      onPressed: signOut,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Cor de fundo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Borda arredondada
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
      child: const Text(
        'Fazer Logout',
        style: TextStyle(fontSize: 18, color: Colors.white), // Texto branco
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.05;
    double paddingVertical = MediaQuery.of(context).size.height * 0.015;

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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza verticalmente
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centraliza horizontalmente
          children: [
            _userInfo(), // Exibe as informações do usuário
            const SizedBox(
                height: 40), // Espaçamento entre as informações e o botão
            _signOutBtn(), // Botão de logout
          ],
        ),
      ),
    );
  }
}
