import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,

        // title: const Text('AppBar Demo'),
        //O TITLE SERÁ UM WIDGET QUE RETORNA UMA ROW COM OS 4 BOTÕES!!!!!
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.food_bank),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.pushNamed(context, '/buscaAlimentos');
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: const Icon(Icons.supervised_user_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.pushNamed(context, '/user');
            },
          ),
          IconButton(
            icon: const Icon(Icons.track_changes_outlined),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.pushNamed(context, '/metas');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
