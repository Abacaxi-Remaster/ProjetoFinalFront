import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CursosPage extends StatefulWidget {
  @override
  CursosPageState createState() => CursosPageState();
}

class CursosPageState extends State<CursosPage> {
  final testesController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Cursos',
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