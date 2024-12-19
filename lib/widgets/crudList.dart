import 'package:flutter/material.dart';
import 'package:comanda_01/services/menu_service.dart'; // Importe a classe MenuService
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudList extends StatelessWidget {
  final ScrollController scrollController;
  final String searchQuery;

  const CrudList({
    super.key,
    required this.scrollController,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;
    final MenuService menuService = MenuService(); // Instância do MenuService

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: menuService
          .searchDishesStream(searchQuery), // Usando o stream de pesquisa
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
          controller: scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: scrollController,
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];

              return ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 20.0),
                leading: Image.asset('assets/images/bufusLogo.jpg'),
                title: Text(
                  dish['name'] ?? 'Sem nome',
                  style: const TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  dish['price']?.toStringAsFixed(2) ?? '0.00',
                  style: const TextStyle(fontSize: 16.0),
                ),
                trailing: SizedBox(
                  width: 110.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _editButton(
                        context,
                        dish['name'] ?? 'Sem nome',
                        dish['price']?.toStringAsFixed(2) ?? '0.00',
                        List<String>.from(dish['tags'] ?? []),
                        mainColor,
                        dish['id'] ?? '', // Verifique se o id está correto
                      ),
                      _deleteButton(
                        context,
                        dish['id'] ?? '', // Verifique se o id está correto
                        mainColor,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              );
            },
          ),
        );
      },
    );
  }

  // Reutilizando os métodos de editar e deletar
  Widget _editButton(BuildContext context, String title, String subtitle,
      List<String> tags, Color color, String dishId) {
    return IconButton(
      icon: Icon(Icons.edit, color: color),
      onPressed: () {
        if (dishId.isNotEmpty) {
          Navigator.pushNamed(
            context,
            'newDishe',
            arguments: {
              'dishId': dishId,
              'dishData': {
                'name': title,
                'price': double.parse(subtitle),
                'tags': tags,
              },
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro: ID do prato não encontrado!')),
          );
        }
      },
    );
  }

  Widget _deleteButton(BuildContext context, String dishId, Color color) {
    return IconButton(
      icon: Icon(Icons.delete, color: color),
      onPressed: () {
        if (dishId.isNotEmpty) {
          _showDeleteConfirmationDialog(context, dishId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro: ID do prato não encontrado!')),
          );
        }
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String dishId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza de que deseja excluir este prato?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('menu')
                      .doc(dishId)
                      .delete();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Prato excluído com sucesso!')),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao excluir o prato: $e')),
                  );
                }
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
