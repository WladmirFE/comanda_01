import 'package:flutter/material.dart';

class InfosTela extends StatelessWidget {
  const InfosTela({
    super.key,
    });

  @override
  Widget build(BuildContext context) {

    final String info1 = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 50, 114),
          title: const Text("DESINFORMAÇÃO!!") ,
        ),


      body: Center(child: Text('Informação recebida: $info1'),),
    );
  }
}