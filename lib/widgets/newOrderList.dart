import 'package:flutter/material.dart';
import 'package:comanda_01/utils/colorPalette.dart';

class NewOrderList extends StatelessWidget {
  final ScrollController scrollController;
  final List<Map<String, dynamic>> orderItems;
  final Function(String, int) onOrderUpdate;
  final Function(String) onRemoveItem;

  const NewOrderList({
    super.key,
    required this.scrollController,
    required this.orderItems,
    required this.onOrderUpdate,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;

    return ListView.builder(
      controller: scrollController,
      itemCount: orderItems.length,
      itemBuilder: (context, index) {
        final item = orderItems[index];
        final dishId = item['id'];

        return ListTile(
          title: Text(item['title']),
          subtitle:
              Text('Preço: ${item['price']} | Quantidade: ${item['quantity']}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (item['quantity'] > 0) {
                    onOrderUpdate(dishId, -1); // Passa o dishId e decrementa
                  }
                },
              ),
              Text(item['quantity'].toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  onOrderUpdate(dishId, 1); // Passa o dishId e incrementa
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onRemoveItem(dishId); // Passa o dishId para remover o item
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
