import 'package:flutter/material.dart';

class ListaEstatica extends StatelessWidget {
  const ListaEstatica({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(
            'assets/images/bufusLogo.jpg',
          ),
          title: const Text('Mini Bufus'),
          subtitle: const Text('Pois é'),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
