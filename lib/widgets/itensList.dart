import 'package:flutter/material.dart';
import 'package:comanda_01/utils/colorPalette.dart';

class ItensList extends StatelessWidget {
  final ScrollController scrollController;

  const ItensList({super.key, required this.scrollController});

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
              icon: Icon(Icons.remove, color: color),
              onPressed: () {},
            ),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: color),
              onPressed: () {},
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
