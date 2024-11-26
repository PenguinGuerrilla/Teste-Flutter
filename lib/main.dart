import 'package:bagun/telas/pesquisacep.dart';
import 'package:flutter/material.dart';
import 'package:bagun/telas/Formulario.dart';
import 'package:bagun/telas/Login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context)=> Login(),
        '/formulario': (context) => Formulario(),
        '/pesquisacep': (context) => PesquisaCep()
      },
    );
  }
}
