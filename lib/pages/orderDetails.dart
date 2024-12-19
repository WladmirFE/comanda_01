import 'package:flutter/material.dart';
import 'package:comanda_01/services/pedido_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_01/utils/colorPalette.dart';

class OrdersDetails extends StatefulWidget {
  final String pedidoId;

  const OrdersDetails({super.key, required this.pedidoId});

  @override
  _OrdersDetailsState createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  late Future<Map<String, dynamic>?> _OrdersDetails;

  @override
  void initState() {
    super.initState();
    _OrdersDetails = PedidoService()
        .getPedidoById(widget.pedidoId); // Busca os detalhes do pedido
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ColorPalette().mainColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do Pedido',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        // Exibe os detalhes do pedido
        future: _OrdersDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final pedido = snapshot.data;

          if (pedido == null) {
            return const Center(child: Text('Pedido não encontrado.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                // Exibição da mesa e status do pedido
                Text(
                  'Mesa: ${pedido['mesa']}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Status do Pedido: ${pedido['pedidoPronto'] ? 'Pronto' : 'Em preparação'}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hora de Confirmação: ${_formatDate(pedido['horaConfirmacao']?.toDate())}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                // Hora de preparação (finalizado)
                Text(
                  'Hora de Finalização: ${_formatDate(pedido['horaPreparacao']?.toDate())}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                // Exibição de quem executou o pedido (usuário)
                Text(
                  'Executado por: ${pedido['usuarioEmail'] ?? 'N/A'}', // Exibe o email ou 'N/A' caso não tenha
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),

                // Exibição dos itens do pedido
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  'Itens do Pedido:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pedido['itens'].length,
                  itemBuilder: (context, index) {
                    final itemId = pedido['itens'].keys.elementAt(index);
                    final itemData = pedido['itens'][itemId];

                    // Exibindo os dados do prato diretamente
                    return ListTile(
                      title: Text('${itemData['nome']}'),
                      subtitle: Text('Quantidade: ${itemData['quantidade']}'),
                      trailing: Text(
                        'R\$ ${itemData['preco'] * itemData['quantidade']}',
                      ),
                    );
                  },
                ),

                // Exibição do total
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  'Total: R\$ ${_calcularTotal(pedido)}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Função para formatar as datas
  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  // Função para calcular o total do pedido
  double _calcularTotal(Map<String, dynamic> pedido) {
    double total = 0.0;
    pedido['itens'].forEach((itemId, itemData) {
      total += itemData['preco'] * itemData['quantidade'];
    });
    return total;
  }
}
