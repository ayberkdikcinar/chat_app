import 'package:flutter/material.dart';

class TextFieldMessage extends StatelessWidget {
  final double borderRadius;
  final Color? backgrounColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final Function(String? val) onChanged;

  const TextFieldMessage(
      {Key? key, required this.borderRadius, this.backgrounColor = Colors.white, this.prefixIcon, this.suffixIcon, this.hintText, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius)),
          filled: true,
          fillColor: backgrounColor,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: Icon(suffixIcon),
          hintText: hintText),
      onChanged: (value) => onChanged(value),
    );
  }
}
