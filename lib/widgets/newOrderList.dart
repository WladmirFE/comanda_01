import 'package:flutter/material.dart';
import 'package:comanda_01/utils/colorPalette.dart';

class NewOrderList extends StatelessWidget {
  final ScrollController scrollController;

  const NewOrderList({super.key, required this.scrollController});

  Widget _actionBtn(
      BuildContext context, String title, String subtitle, Color color) {
    return ListTile(
      textColor: Colors.white,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20.0),
      leading: Image.asset(
        'assets/images/bufusLogo.jpg',
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14.0),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12.0),
      ),
      trailing: SizedBox(
        width: 150.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
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
              icon: const Icon(Icons.add, color: Colors.white),
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView(
        controller: scrollController,
        children: [
          Container(
            height: screenHeight * 0.07,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),
          ),
          _actionBtn(
            context,
            'Sapo gormer, ultra fino',
            '1,99',
            mainColor,
          ),
        ],
      ),
    );
  }
}
