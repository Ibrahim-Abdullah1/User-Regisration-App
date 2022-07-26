import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "Welcome Dear User",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.deepPurpleAccent),
    ));
  }
}
