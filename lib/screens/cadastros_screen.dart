import 'package:flutter/material.dart';
import '../components/main_drawer.dart';

class CadastrosScreen extends StatelessWidget {
  const CadastrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastros"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Cadastros"),
      ),
    );
  }
}