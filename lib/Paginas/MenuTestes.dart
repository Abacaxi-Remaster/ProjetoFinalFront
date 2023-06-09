import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class TestesPage extends StatelessWidget {
  final testesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Atividades Concluídas', style: TextStyle(fontSize: 25)),
        //for (var testesAlunos in appState.teste)
        ExpansionTile(
          title: Text('Nome Aluno'),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 1'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 2'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Nome Aluno 2'),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 1'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 2'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TestesPageMentor extends StatelessWidget {
  final testesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Atividades Concluídas', style: TextStyle(fontSize: 25)),
        //for (var testesAlunos in appState.teste)
        ExpansionTile(
          title: Text('Nome Aluno'),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 1'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 2'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Nome Aluno 2'),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 1'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 2'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 2'),
                    subtitle: Text('Nota: 0'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
