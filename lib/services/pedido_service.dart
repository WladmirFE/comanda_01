import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoService {
  final CollectionReference _pedidoCollection =
      FirebaseFirestore.instance.collection('pedidos');

  // Adiciona um novo pedido e retorna o ID
  Future<String> addPedido({
    required String mesa,
    required Map<String, Map<String, dynamic>> itens,
    String? usuarioEmail,
    DateTime? horaConfirmacao,
    bool pedidoPronto = false,
    DateTime? horaPreparacao,
  }) async {
    try {
      // Converte o Map<String, Map<String, dynamic>> para um formato serializável
      final serializedItens = itens.map((key, value) => MapEntry(key, {
            'nome': value['nome'],
            'preco': value['preco'],
            'quantidade': value['quantidade'],
          }));

      var docRef = await _pedidoCollection.add({
        'mesa': mesa,
        'itens': serializedItens,
        'usuarioEmail': usuarioEmail,
        'horaConfirmacao': horaConfirmacao != null
            ? Timestamp.fromDate(horaConfirmacao)
            : null,
        'pedidoPronto': pedidoPronto,
        'horaPreparacao':
            horaPreparacao != null ? Timestamp.fromDate(horaPreparacao) : null,
        'createdAt': Timestamp.now(),
      });

      return docRef.id; // Retorna o ID do pedido recém-criado
    } catch (e) {
      throw Exception('Erro ao adicionar o pedido: $e');
    }
  }

  // Atualiza um pedido existente
  Future<void> updatePedido(
    String id, {
    String? mesa,
    Map<String, Map<String, dynamic>>? itens,
    bool? pedidoPronto,
    DateTime? horaPreparacao,
  }) async {
    try {
      Map<String, dynamic> updates = {};
      if (mesa != null) updates['mesa'] = mesa;
      if (itens != null) {
        updates['itens'] = itens.map((key, value) => MapEntry(key, {
              'quantidade': value['quantidade'],
              'nome': value['nome'],
              'preco': value['preco'],
            }));
      }
      if (pedidoPronto != null) updates['pedidoPronto'] = pedidoPronto;
      if (horaPreparacao != null) {
        updates['horaPreparacao'] = Timestamp.fromDate(horaPreparacao);
      }
      updates['updatedAt'] = Timestamp.now();

      await _pedidoCollection.doc(id).update(updates);
    } catch (e) {
      throw Exception('Erro ao atualizar o pedido: $e');
    }
  }

  // Remove um pedido existente
  Future<void> removePedido(String id) async {
    try {
      await _pedidoCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao remover o pedido: $e');
    }
  }

  // Obtém um pedido pelo ID
  Future<Map<String, dynamic>?> getPedidoById(String id) async {
    try {
      DocumentSnapshot doc = await _pedidoCollection.doc(id).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      } else {
        return null; // Retorna nulo se o pedido não existir
      }
    } catch (e) {
      throw Exception('Erro ao buscar o pedido: $e');
    }
  }

  // Função que retorna um Stream de pedidos
  Stream<List<Map<String, dynamic>>> getPedidosStream() {
    return _pedidoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Adiciona o ID do pedido aos dados
        return data;
      }).toList();
    });
  }

  // Função para buscar pedidos por status (pronto ou não)
  Stream<List<Map<String, dynamic>>> getPedidosPorStatusStream(
      {required bool pedidoPronto}) {
    return _pedidoCollection
        .where('pedidoPronto', isEqualTo: pedidoPronto)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
