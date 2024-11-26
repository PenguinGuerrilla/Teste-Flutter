import 'package:flutter/material.dart';
import 'package:bagun/modelos/Usuario.dart';
import 'package:intl/intl.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool mostraBotao = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Usuario.verificaUsuario().then((user) {
      if (user != null) {
        Navigator.pushNamed(context, '/dashboard');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Widget botaoLogin(){
    return SizedBox(
      child: ElevatedButton(
          onPressed: () {
            DateTime data = DateTime.now();
            String dataLogin = DateFormat('dd-MM--yyyy - kk:mm').format(data);
            print(dataLogin);
            Usuario u = Usuario(
                usernameController.text, passwordController.text, dataLogin);

            setState(() {
              mostraBotao = false;
            });

            u.autentica().then((resposta) {
              if (resposta != null) {
                if (resposta['resposta'] != 'ok') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(resposta['motivo'])));
                  setState(() {
                    mostraBotao = true;
                  });
                } else {
                  u.insereUsuario().then((resposta) {
                    if (resposta > 0) {
                      Navigator.pushReplacementNamed(context, '/formulario');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Erro ao tentar conectar ao banco')));
                    }
                  });
                }
              }
            });
          },
        child: Text("Entrar"),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 300,
          // child: Image(image: AssetImage('assets/img/logo.jpeg')),
          child: Image.asset('assets/uni.png',
              errorBuilder: (context, error, stackTrace) =>
                  Text('Imagem não encontrada')),
        ),
        SizedBox(height: 35),
        SizedBox(
          width: 300,
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Username'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 300,
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Password'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        
        SizedBox(height: 10),
        mostraBotao ?
          botaoLogin():
          SizedBox(
            width: 300,
            child: Center(child: CircularProgressIndicator()),
          )
        
      ]),
    ));
  }
}
