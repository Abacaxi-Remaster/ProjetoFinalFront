import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class AtConcluidasMentorPage extends StatelessWidget {
  final testesController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Atividades concluidas',
              style: TextStyle(fontSize: 25)),
        for (var treinamentosAlunos in appState.treinar)
          ListTile(
            leading: Icon(Icons.task),
            title: Text(treinamentosAlunos),
          ),
        for (var testesAlunos in appState.teste)
          ListTile(
            leading: Icon(Icons.task),
            title: Text(testesAlunos),
          ),
      ],
    );
  }
}

class AtConcluidasAlunosPage extends StatelessWidget {
  final testesController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Treinamentos em curso',
              style: TextStyle(fontSize: 25)),
        for (var treinamentosAlunos in appState.treinar)
            ListTile(
              leading: Icon(Icons.task),
              title: Text(treinamentosAlunos),
            ),
        for (var testesAlunos in appState.teste)
          ListTile(
            leading: Icon(Icons.task),
            title: Text(testesAlunos),
          ),
      ],
    );
  }
}