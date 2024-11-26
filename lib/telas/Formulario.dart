import 'package:bagun/modelos/Usuario.dart';
import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Formulário
          formulario(),
          // Botões
          botoes()
        ],
      ),
    );
  }

  final _keyForm = GlobalKey<FormState>();
  Map<String, String> formularioSalvo = {};

  Widget formulario() {
    return Form(
      key: _keyForm,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              onSaved: (valor) {
                formularioSalvo['nome'] = valor!;
              },
              validator: (entrada) {
                if (entrada!.isEmpty) {
                  return 'Nome requerido.';
                } else if (entrada.contains(' ') == false) {
                  return 'Forneça um nome completo.';
                }

                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nome'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              onSaved: (valor) {
                formularioSalvo['email'] = valor!;
              },
              validator: (entrada) {
                if (entrada!.contains('@') == false) {
                  return 'Insira um email válido.';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail',
                hintText: 'exemplo@dominio.com',
                hintStyle: TextStyle(color: Colors.black26),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget botoes() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                if (_keyForm.currentState!.validate() == true) {
                  _keyForm.currentState!.save();

                  print(formularioSalvo);
                }
              },
              child: Text('Salvar')),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {}, child: Text('Enviar'))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Usuario.verificaUsuario().then((u) {
                    u!.removeUsuario().then((value) {
                      Navigator.pushReplacementNamed(context, '/');
                    });
                  });
                },
                child: Text('Logout'))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/pesquisacep');
                },
                child: Text('P'))),
      ],
    ));
  }
}
