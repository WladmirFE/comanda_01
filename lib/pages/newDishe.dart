import 'package:flutter/material.dart';
import 'package:comanda_01/widgets/entryField.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewDishe extends StatefulWidget {
  const NewDishe({super.key});

  @override
  State<NewDishe> createState() => _NewDisheState();
}

class _NewDisheState extends State<NewDishe> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerPreco = TextEditingController();
  final TextEditingController _controllerTags = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double paddingHorizontal = screenWidth * 0.05;
    double paddingVertical = screenHeight * 0.015;

    final mainColor = ColorPalette().mainColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicione um novo prato',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: paddingVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  EntryField(
                    color: mainColor,
                    title: 'Nome do produto',
                    icon: FaIcon(
                      FontAwesomeIcons.utensils,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerNome,
                  ),
                  const SizedBox(height: 15),
                  EntryField(
                    color: mainColor,
                    title: 'Preço',
                    icon: FaIcon(
                      FontAwesomeIcons.dollarSign,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerPreco,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _controllerTags,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Tags (ex: descrição ou palavras-chave)',
                      labelStyle: TextStyle(color: mainColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      print('Novo prato adicionado:');
                      print('Nome: ${_controllerNome.text}');
                      print('Preço: ${_controllerPreco.text}');
                      print('Tags: ${_controllerTags.text}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Adicionar novo prato',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
