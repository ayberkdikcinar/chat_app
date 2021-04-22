import '../../extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imageUrl;
  final double? firstRadius;
  final double? secRadius;
  const CustomCircleAvatar({
    Key? key,
    required this.imageUrl,
    this.firstRadius = 29,
    this.secRadius = 26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.theme.accentColor,
      radius: firstRadius,
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: secRadius,
      ),
    );
  }
}
