import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class VagasPage extends StatelessWidget {
  final vagasController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Vagas',
              style: TextStyle(fontSize: 25)),
        for (var vagasAlunos in appState.vaga)
          ListTile(
            leading: Icon(Icons.task),
            title: Text(vagasAlunos),
          ),
      ],
    );
  }
}