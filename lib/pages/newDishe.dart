import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_01/services/menu_service.dart';
import 'package:comanda_01/widgets/entryField.dart';
import 'package:comanda_01/utils/colorPalette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewDishe extends StatefulWidget {
  const NewDishe({super.key});

  @override
  State<NewDishe> createState() => _NewDisheState();
}

class _NewDisheState extends State<NewDishe> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerPreco = TextEditingController();
  final TextEditingController _controllerTags = TextEditingController();
  final MenuService _menuService = MenuService();

  String? _dishId;
  Map<String, dynamic>? _dishData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      _dishId = args['dishId'];
      _dishData = args['dishData'];

      // Preenche os campos se for edição
      if (_dishData != null) {
        _controllerNome.text = _dishData!['name'];
        _controllerPreco.text = _dishData!['price'].toString();
        _controllerTags.text = (_dishData!['tags'] as List).join(', ');
      }
    }
  }

  void _saveDish() async {
    String name = _controllerNome.text.trim();
    double? price = double.tryParse(_controllerPreco.text.trim());
    String tags = _controllerTags.text.trim();

    if (name.isEmpty || price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente!')),
      );
      return;
    }

    try {
      if (_dishId != null) {
        // Atualiza prato existente
        await _menuService.updateDish(
          _dishId!,
          name: name,
          price: price,
          tags: tags,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prato atualizado com sucesso!')),
        );
      } else {
        // Adiciona um novo prato
        await _menuService.addDish(name, price, tags);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prato adicionado com sucesso!')),
        );
      }
      Navigator.pop(context); // Volta para a lista após salvar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar prato: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = ColorPalette().mainColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _dishId == null ? 'Adicionar novo prato' : 'Editar prato',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            EntryField(
              color: mainColor,
              title: 'Nome do produto',
              icon: FaIcon(
                FontAwesomeIcons.utensils,
                size: 30.0,
                color: mainColor,
              ),
              controller: _controllerNome,
            ),
            const SizedBox(height: 15),
            EntryField(
              color: mainColor,
              title: 'Preço',
              icon: FaIcon(
                FontAwesomeIcons.dollarSign,
                size: 30.0,
                color: mainColor,
              ),
              controller: _controllerPreco,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _controllerTags,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Tags (ex: descrição ou palavras-chave)',
                labelStyle: TextStyle(color: mainColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _saveDish,
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                _dishId == null ? 'Adicionar novo prato' : 'Atualizar prato',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
