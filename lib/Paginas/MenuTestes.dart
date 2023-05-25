import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class TestesPage extends StatelessWidget {
  final testesController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Testes',
              style: TextStyle(fontSize: 25,)),
        for (var testesAlunos in appState.teste)
          ListTile(
            leading: Icon(Icons.task),
            title: Text(testesAlunos),
          ),
      ],
    );
  }
}