import 'package:flutter/material.dart';
import 'customText01.dart';

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 50, 114),
          title: const Center(child: CustomText01(text: "Cavalo", containerColor: Colors.white, textColor: Colors.black),) ,
        ),


      body: Center(),
    );
  }
}