import 'package:bagun/modelos/db/banco.dart';
import 'package:dio/dio.dart';

class Usuario {
  String? username;
  String? password;
  String? ultimoLogin;

  Usuario(this.username, this.password, this.ultimoLogin);

  Future<Map?> autentica() async {
    try {
      Response resposta = await Dio().post(
          'https://tarrafa.unimontes.br/aula/autentica',
          data: {'username': username, 'password': password});

      if (resposta.statusCode == 200) {
        return resposta.data;
      }

    

    } on DioException {
      return {'resposta': 'Erro', 'motivo': 'servidor não encontrado'};
    }

    return null;
  }

  Future<int> insereUsuario() async {
    final db = await Banco.instance.database;
    return db.rawInsert("""
    insert or replace into user(username,password,ultimo_login)
    values('$username','$password','$ultimoLogin')
    """);
  }

  Future<int> removeUsuario() async {
    final db = await Banco.instance.database;
    return db.rawDelete("""
      delete from user where username = '$username'
    """);
  }

  static Future<Usuario?> verificaUsuario() async {
    final db = await Banco.instance.database;
    List<Map<String, Object?>> lista = await db.rawQuery('select * from user');

    if (lista.isNotEmpty) {
      Map<String, Object?> utemp = lista.first;
      Usuario user = Usuario(utemp['username'].toString(),
          utemp['password'].toString(), utemp['ultimo_login'].toString());
      return user;
    }
    return null;
  }
}
