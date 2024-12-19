class Pedido {
  final String id;
  String mesa;
  Map<String, Map<String, dynamic>>
      itens; // Estrutura para armazenar nome, preço e quantidade de cada item
  String? usuarioEmail;
  DateTime? horaConfirmacao;
  bool pedidoPronto;
  DateTime? horaPreparacao;

  Pedido({
    required this.id,
    required this.mesa,
    required this.itens,
    this.usuarioEmail,
    this.horaConfirmacao,
    this.pedidoPronto = false,
    this.horaPreparacao,
  });

  /// Atualiza a quantidade de um prato no pedido
  void atualizarQuantidade(String pratoId, int quantidade,
      {String nome = '', double preco = 0.0}) {
    if (itens.containsKey(pratoId)) {
      // Atualiza a quantidade existente
      itens[pratoId]!['quantidade'] =
          (itens[pratoId]!['quantidade'] + quantidade)
              .clamp(0, double.infinity)
              .toInt();

      // Remove o prato caso a quantidade seja zero
      if (itens[pratoId]!['quantidade'] == 0) {
        itens.remove(pratoId);
      }
    } else if (quantidade > 0) {
      // Adiciona um novo prato ao pedido, se não existir e a quantidade for maior que zero
      itens[pratoId] = {
        'quantidade': quantidade,
        'nome': nome,
        'preco': preco,
      };
    }
  }

  /// Remove um prato do pedido
  void removerItem(String pratoId) {
    itens.remove(pratoId);
  }

  /// Calcula o total do pedido com base nos itens e suas quantidades
  double calcularTotal(List<Map<String, dynamic>> pratos) {
    double total = 0.0;

    for (var item in itens.entries) {
      final prato = pratos.firstWhere(
        (p) => p['id'] == item.key,
        orElse: () => {'preco': 0.0}, // Caso o prato não seja encontrado
      );

      total += (prato['preco'] ?? 0.0) * item.value['quantidade'];
    }

    return total;
  }

  /// Retorna os detalhes do pedido como um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'mesa': mesa,
      'itens': itens.map((key, value) {
        return MapEntry(
          key,
          {
            'nome': value['nome'],
            'quantidade': value['quantidade'],
            'preco': value['preco'],
          },
        );
      }),
      'usuarioEmail': usuarioEmail,
      'horaConfirmacao': horaConfirmacao?.toIso8601String(),
      'pedidoPronto': pedidoPronto,
      'horaPreparacao': horaPreparacao?.toIso8601String(),
    };
  }
}
