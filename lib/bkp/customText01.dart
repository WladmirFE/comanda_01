import 'package:flutter/material.dart';

class CustomText01 extends StatelessWidget {

  const CustomText01({
    super.key, 
    required this.text, 
    required this.containerColor, 
    required this.textColor
  });

  final String text;
  final Color containerColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(

      color: containerColor,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
            
        ),
      ),
    );
  }
}