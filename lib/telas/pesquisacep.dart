import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PesquisaCep extends StatefulWidget {
  const PesquisaCep({super.key});

  @override
  State<PesquisaCep> createState() => _PesquisaCepState();
}

class _PesquisaCepState extends State<PesquisaCep> {
  late TextEditingController cepCntrl;
  Future<Map>? cepDados;

  Future<Map> BuscaCep() async {
    try {
      String cep = cepCntrl.text;
      cep = cep.trim();
      if (cep.isEmpty) return {'Erro': 'Digite um CEP válido'};
      Response resposta = await Dio().get(
        'https://brasilapi.com.br/api/cep/v2/${cep}',
      );

      if (resposta.statusCode == 200) {
        return resposta.data;
      }
    } on DioException {
      return {'Erro': 'Serviço não encontrado!'};
    }

    return {'Erro': 'Erro no servidor'};
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cepCntrl = TextEditingController();
    cepDados = BuscaCep();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cepCntrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Insira um CEP'),
                        controller: cepCntrl,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              cepDados = BuscaCep();
                            });
                          },
                          icon: Icon(Icons.search)),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: FutureBuilder<Map>(
                  future: cepDados,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    Map? dados = snapshot.data!;

                    if (dados.containsKey('Erro')) {
                      return Center(child: Text(dados['Erro']));
                    }

                    /* return ListView(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text('Cidade'),
                            subtitle: Text(dados['city']),
                            leading: Icon(Icons.location_city_rounded),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Rua'),
                            subtitle: Text(dados['street']),
                            leading: Icon(Icons.streetview),
                          ),
                        ),
                      ],
                    );*/

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(dados.keys.elementAt(index)),
                            subtitle: Text(dados.values.elementAt(index).toString()),
                          ),
                        );
                      },
                      itemCount: dados.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
