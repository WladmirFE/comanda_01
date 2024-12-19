import 'package:flutter/material.dart';
import 'package:comanda_01/widgets/entryField.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/widgets/crudList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:comanda_01/services/pedido_service.dart';
import 'package:comanda_01/pages/orderDetails.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final TextEditingController _controllerPesquisa = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery =
      ''; // Usando uma string para armazenar a consulta de pesquisa
  late Stream<List<Map<String, dynamic>>> _pedidosStream;

  @override
  void initState() {
    super.initState();
    _controllerPesquisa.addListener(_performSearch);
    _pedidosStream =
        PedidoService().getPedidosStream(); // Inicia o Stream de pedidos
  }

  @override
  void dispose() {
    _controllerPesquisa.removeListener(_performSearch); // Remover o listener
    _controllerPesquisa.dispose();
    super.dispose();
  }

  // Função para realizar a pesquisa
  void _performSearch() {
    setState(() {
      _searchQuery =
          _controllerPesquisa.text.trim(); // Atualiza a consulta de pesquisa
    });
  }

  // Função de confirmação de exclusão de pedido
  void _confirmarExclusao(String pedidoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza que deseja excluir este pedido?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha a caixa de diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await PedidoService().removePedido(pedidoId);
                Navigator.of(context).pop(); // Fecha a caixa de diálogo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pedido removido')),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
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
        title: const Text(
          'Lista de Pedidos',
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
                    title: 'Pesquise por nome, mesa...',
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 30.0,
                      color: mainColor,
                    ),
                    controller: _controllerPesquisa,
                  ),
                  const SizedBox(height: 15),
                  // Lista de pedidos
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 216, 216),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: screenHeight * 0.7,
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _pedidosStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Nenhum pedido encontrado'));
                        }

                        // Filtrando a lista de pedidos conforme a pesquisa
                        final pedidos = snapshot.data!.where((pedido) {
                          final mesa = pedido['mesa']?.toLowerCase() ?? '';
                          return mesa.contains(_searchQuery.toLowerCase());
                        }).toList();

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: pedidos.length,
                          itemBuilder: (context, index) {
                            final pedido = pedidos[index];
                            return ListTile(
                              title: Text('Mesa: ${pedido['mesa']}'),
                              subtitle: Text(
                                  'Status: ${pedido['pedidoPronto'] ? 'Pronto' : 'Em preparação'}'),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _confirmarExclusao(pedido['id']);
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrdersDetails(pedidoId: pedido['id']),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
