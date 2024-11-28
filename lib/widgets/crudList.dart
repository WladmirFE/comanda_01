import 'package:flutter/material.dart';

import 'package:comanda_01/utils/colorPalette.dart';

class CrudList extends StatelessWidget {
  final ScrollController scrollController;

  const CrudList({super.key, required this.scrollController});

  Widget _actionBtn(
      BuildContext context, String title, String subtitle, Color color) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20.0),
      leading: Image.asset(
        'assets/images/bufusLogo.jpg',
      ),
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
              icon: Icon(Icons.edit, color: color),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete, color: color),
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza de que deseja excluir este item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView(controller: scrollController, children: [
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
        _actionBtn(
          context,
          'Sapo gormer, ultra fino',
          '1,99',
          mainColor,
        ),
      ]),
    );
  }
}
