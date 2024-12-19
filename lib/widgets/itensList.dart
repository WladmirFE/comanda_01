import 'package:flutter/material.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:comanda_01/services/menu_service.dart';

class ItensList extends StatefulWidget {
  final ScrollController scrollController;
  final String searchQuery;
  final Map<String, int> quantities; // Quantidades sincronizadas com o Pedido
  final Function(String, int) onOrderUpdate;

  const ItensList({
    super.key,
    required this.scrollController,
    required this.searchQuery,
    required this.quantities,
    required this.onOrderUpdate,
  });

  @override
  _ItensListState createState() => _ItensListState();
}

class _ItensListState extends State<ItensList> {
  Widget _actionBtn(BuildContext context, String dishId, String title,
      String subtitle, Color color, int quantity) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20.0),
      leading: Image.asset('assets/images/bufusLogo.jpg'),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 16.0),
      ),
      trailing: SizedBox(
        width: 110.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: color),
              onPressed: () {
                if (quantity > 0) {
                  widget.onOrderUpdate(dishId, -1); // Decrementa a quantidade
                }
              },
            ),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  quantity.toString(), // Exibe a quantidade atual
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: color),
              onPressed: () {
                widget.onOrderUpdate(dishId, 1); // Incrementa a quantidade
              },
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;
    final MenuService menuService = MenuService();

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: menuService.searchDishesStream(widget.searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum prato encontrado.'));
        }

        final dishes = snapshot.data!;

        return Scrollbar(
          controller: widget.scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];
              final dishId = dish['id'] ?? 'no-id';
              final quantity =
                  widget.quantities[dishId] ?? 0; // Quantidade sincronizada

              return _actionBtn(
                context,
                dishId,
                dish['name'] ?? 'Sem nome',
                dish['price']?.toStringAsFixed(2) ?? '0.00',
                mainColor,
                quantity,
              );
            },
          ),
        );
      },
    );
  }
}
