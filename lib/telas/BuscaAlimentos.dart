import 'package:flutter/material.dart';

class BuscaAlimentos extends StatefulWidget {
  const BuscaAlimentos({super.key});

  @override
  State<BuscaAlimentos> createState() => _BuscaAlimentosState();
}

class _BuscaAlimentosState extends State<BuscaAlimentos> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Busca Alimento'));
  }
}
