import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_01/widgets/entryField.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/widgets/itensList.dart';
import 'package:comanda_01/widgets/newOrderList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comanda_01/models/Pedido.dart';
import 'package:comanda_01/services/auth.dart';
import 'package:comanda_01/services/pedido_service.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final TextEditingController _controllerPesquisa = TextEditingController();
  final TextEditingController _controllerMesa = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late Pedido _pedido;
  List<Map<String, dynamic>> _pratos = [];

  @override
  void initState() {
    super.initState();

    final String? userEmail = Auth().currerntUser?.email;
    _pedido = Pedido(
      id: 'pedido123',
      mesa: '',
      itens: {},
      usuarioEmail: userEmail,
    );
    _loadPratos();
  }

  void _loadPratos() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('menu').get();
      List<Map<String, dynamic>> pratos = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'nome': doc['name'],
          'preco': doc['price'],
        };
      }).toList();

      setState(() {
        _pratos = pratos;
      });
    } catch (e) {
      print('Erro ao carregar pratos: $e');
    }
  }

  void _confirmarPedido() async {
    if (_controllerMesa.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O campo "Mesa" é obrigatório.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _pedido.mesa = _controllerMesa.text.trim();
    _pedido.horaConfirmacao = DateTime.now();

    final total = _pedido.calcularTotal(_pratos);

    try {
      final pedidoService = PedidoService();
      final pedidoId = await pedidoService.addPedido(
        mesa: _pedido.mesa,
        itens: _pedido
            .itens, // Passa diretamente o Map<String, Map<String, dynamic>>
        usuarioEmail: _pedido.usuarioEmail,
        horaConfirmacao: _pedido.horaConfirmacao,
      );
      ;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pedido confirmado! ID: $pedidoId'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao confirmar pedido: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingHorizontal = screenWidth * 0.05;
    double paddingVertical = screenHeight * 0.015;

    final mainColor = ColorPalette().mainColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Pedido', style: TextStyle(color: Colors.white)),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: paddingVertical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  EntryField(
                    color: mainColor,
                    title: 'Pesquise por nome, ID, ou tags...',
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass,
                        size: 30.0, color: mainColor),
                    controller: _controllerPesquisa,
                  ),
                  const SizedBox(height: 10),
                  EntryField(
                    color: mainColor,
                    title: 'Mesa',
                    icon: FaIcon(FontAwesomeIcons.utensils,
                        size: 30.0, color: mainColor),
                    controller: _controllerMesa,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: screenHeight * 0.5,
                    child: ItensList(
                      scrollController: _scrollController,
                      searchQuery: _controllerPesquisa.text,
                      quantities: _pedido.itens.map((key, value) => MapEntry(
                          key, value['quantidade'] as int)), // Convertido
                      onOrderUpdate: (dishId, quantidade) {
                        setState(() {
                          final prato = _pratos.firstWhere(
                            (prato) => prato['id'] == dishId,
                            orElse: () => {'nome': '', 'preco': 0.0},
                          );
                          _pedido.atualizarQuantidade(dishId, quantidade,
                              nome: prato['nome'] ?? '',
                              preco: prato['preco'] ?? 0.0);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 218, 87, 0),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: NewOrderList(
                          scrollController: scrollController,
                          orderItems: _pedido.itens.entries.map((e) {
                            final prato = _pratos.firstWhere(
                              (prato) => prato['id'] == e.key,
                              orElse: () =>
                                  {'nome': 'Desconhecido', 'preco': 0.0},
                            );
                            return {
                              'id': e.key,
                              'title': prato['nome'],
                              'price':
                                  'R\$${prato['preco'].toStringAsFixed(2)}',
                              'quantity': e.value['quantidade'],
                            };
                          }).toList(),
                          onOrderUpdate: (dishId, quantidade) {
                            setState(() {
                              _pedido.atualizarQuantidade(dishId, quantidade);
                            });
                          },
                          onRemoveItem: (dishId) {
                            setState(() {
                              _pedido.removerItem(dishId);
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _confirmarPedido,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Confirmar Pedido: R\$${_pedido.calcularTotal(_pratos).toStringAsFixed(2)}',
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
