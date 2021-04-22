import 'package:flutter/material.dart';

import '../../extension/context_extension.dart';

class TextButtonSend extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;

  const TextButtonSend({
    Key? key,
    required this.onPressed,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(CircleBorder()),
      ),
      child: buildIcon(context),
    );
  }

  Icon buildIcon(BuildContext context) => Icon(icon, color: context.theme.highlightColor);
}
