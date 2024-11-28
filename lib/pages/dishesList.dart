import 'package:flutter/material.dart';
import 'package:comanda_01/widgets/entryField.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/widgets/crudList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DishesList extends StatefulWidget {
  const DishesList({super.key});

  @override
  State<DishesList> createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> {
  final TextEditingController _controllerPesquisa = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
          'Lista de pratos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    title: 'Pesquise por nome, ID, ou tags...',
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerPesquisa,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: screenHeight * 0.7,
                    child: CrudList(scrollController: _scrollController),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'newDishe');
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
