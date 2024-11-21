import 'package:flutter/material.dart';
import 'package:comanda_01/widgets/entryField.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/widgets/itensList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final TextEditingController _controllerPesquisa = TextEditingController();
  final TextEditingController _controllerMesa = TextEditingController();

  // Controlador compartilhado
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
          'Novo Pedido',
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
                    title: 'Pesquise por nome, ID, ou tags...',
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerPesquisa,
                  ),
                  const SizedBox(height: 10),
                  EntryField(
                    color: mainColor,
                    title: 'Mesa',
                    icon: FaIcon(
                      FontAwesomeIcons.utensils,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerMesa,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: screenHeight * 0.43,
                    child: ItensList(
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3, // Tamanho inicial (15% da tela)
            minChildSize: 0.3, // Tamanho mínimo (15% da tela)
            maxChildSize: 0.7, // Tamanho máximo ajustado (70% da tela)
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 218, 87, 0),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0), // Bordas arredondadas no topo
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Indicador de "arrasto" no topo
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                    ),
                    // Lista de itens
                    Expanded(
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: ItensList(scrollController: scrollController),
                      ),
                    ),
                    // Botão de confirmação
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Adicione a lógica do seu botão de confirmação aqui
                          print('Pedido confirmado!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Confirmar Pedido: 19,00',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
