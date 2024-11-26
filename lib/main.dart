import 'package:bagun/modelos/Usuario.dart';
import 'package:bagun/telas/BuscaAlimentos.dart';
import 'package:bagun/telas/Dashboard.dart';
import 'package:bagun/telas/Metas.dart';
import 'package:bagun/telas/User.dart';
import 'package:bagun/telas/pesquisacep.dart';
import 'package:flutter/material.dart';
import 'package:bagun/telas/Dashboard.dart';
import 'package:bagun/telas/Login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/dashboard',
      routes: {
        '/': (context)=> Login(),
        '/dashboard': (context) => Dashboard(),
        '/metas': (context) => Metas(),
        '/buscaAlimentos': (context) => BuscaAlimentos(),
        '/user': (context) => User()
      },
    );
  }
}
