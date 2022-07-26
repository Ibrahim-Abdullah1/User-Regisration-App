import 'package:flutter/material.dart';

// ignore: camel_case_types
class bg_image extends StatelessWidget {
  const bg_image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/bg.jpg",
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(0.5),
      colorBlendMode: BlendMode.darken,
    );
  }
}
