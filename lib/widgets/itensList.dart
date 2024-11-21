import 'package:flutter/material.dart';

import 'package:comanda_01/utils/colorPalette.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItensList extends StatelessWidget {
  final ScrollController scrollController;

  const ItensList({super.key, required this.scrollController});

  Widget _actionBtn(BuildContext context, String route, String title,
      String subtitle, Color color, FaIcon mainIcon) {
    return ListTile(
      dense: true, // Ajusta o tamanho geral do ListTile
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 5, vertical: 20.0), // Ajuste a altura
      leading: Image.asset(
        'assets/images/bufusLogo.jpg',
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0), // Aumenta o tamanho da fonte
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 16.0), // Aumenta o tamanho da fonte
      ),
      trailing: SizedBox(
        width: 110.0, // Ajuste a largura para comportar os ícones e número
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Alinha tudo à direita
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: color),
              onPressed: () {
                // Aqui você pode implementar a funcionalidade de subtração
              },
            ),
            Flexible(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  '0', // Número central
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: color),
              onPressed: () {
                // Aqui você pode implementar a funcionalidade de adição
              },
            ),
          ],
        ),
      ),
      onTap: () {
        //Navigator.pushNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView(
        controller: scrollController, // Usa o mesmo ScrollController
        children: [
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
          _actionBtn(
              context,
              'newOrder',
              'Sapo gormer, ultra fino',
              '1,99',
              mainColor,
              FaIcon(
                FontAwesomeIcons.burger,
                size: 30.0,
                color: mainColor,
              )),
        ],
      ),
    );
  }
}
