import 'package:flutter/material.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainActionsList extends StatelessWidget {
  const MainActionsList({super.key});

  Widget _actionBtn(BuildContext context, String route, String title,
      String subtitle, Color color, FaIcon mainIcon) {
    return ListTile(
      dense: true, // Ajusta o tamanho geral do ListTile
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0), // Ajuste a altura
      leading: mainIcon,
      title: Text(
        title,
        style: const TextStyle(fontSize: 24.0), // Aumenta o tamanho da fonte
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 18.0), // Aumenta o tamanho da fonte
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: color,
        size: 30.0, // Aumenta o tamanho do ícone
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = ColorPalette().mainColor;
    return Expanded(
        child: ListView(
      children: [
        _actionBtn(
            context,
            'newOrder',
            'Novo Pedido',
            'Realize um novo pedido',
            mainColor,
            FaIcon(
              FontAwesomeIcons.burger,
              size: 30.0,
              color: mainColor,
            )),
        _actionBtn(
            context,
            'newOrder',
            'Editar Pratos',
            'Edite ou exclua dados do menu',
            mainColor,
            FaIcon(
              FontAwesomeIcons.clipboard,
              size: 30.0,
              color: mainColor,
            )),
        _actionBtn(
            context,
            'newOrder',
            'Configurar Local',
            'Configure elementos do estabelecimento',
            mainColor,
            FaIcon(
              FontAwesomeIcons.store,
              size: 30.0,
              color: mainColor,
            )),
        _actionBtn(
            context,
            'newOrder',
            'Pedidos Arquivados',
            'Consulte pedidos arquivados',
            mainColor,
            FaIcon(
              FontAwesomeIcons.boxArchive,
              size: 30.0,
              color: mainColor,
            )),
      ],
    ));
  }
}
