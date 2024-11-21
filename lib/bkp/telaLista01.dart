import 'package:flutter/material.dart';
import 'package:comanda_01/bkp/listaEstatica.dart';

class TelaLista01 extends StatelessWidget {
  const TelaLista01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 218, 0, 0),
        title: const Center(
          child: Text("Lista Estatica"),
        ),
      ),
      body: const Center(
        child: ListaEstatica(),
      ),
    );
  }
}
