import 'package:flutter/material.dart';
import 'package:project/menu.dart';

class HomePange extends StatefulWidget {
  const HomePange({super.key});

  @override
  State<HomePange> createState() => _HomePangeState();
}

class _HomePangeState extends State<HomePange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY APP"),
      ),
      drawer: drawer(context),
    );
  }
}