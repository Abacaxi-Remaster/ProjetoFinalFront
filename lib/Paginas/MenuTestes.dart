import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../main.dart';
import '../all.dart';
import 'FazerQuiz.dart';

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

class TestesPageAluno extends StatelessWidget {
  final testesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FutureBuilder<List<TreinamentoNotas>>(
      future: listTreinamentoAluno(appState.logged.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
          ); // Display an error message if data retrieval fails
        } else {
          List<TreinamentoNotas>? treinamentos = snapshot.data;

          return ListView(
            children: [
              Text('Atividades Concluídas', style: TextStyle(fontSize: 25)),
              for (var testesAlunos in treinamentos!)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ExpansionTile(
                    title: Text(testesAlunos.treinamento.nomeComercial),
                    children: [
                      ListTile(
                        leading: Icon(Icons.task_alt),
                        title: Text('Teste de aptidão'),
                        subtitle: Text('Nota: ${testesAlunos.notaTesteA}'),
                      ),
                      ListTile(
                        leading: Icon(Icons.task),
                        title: Text('Teste 1'),
                        subtitle: Text('Nota: ${testesAlunos.notaTeste1}'),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          tooltip: 'Fazer teste',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Iniciar teste 1'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Confirmar e começar teste'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        appState.idTreinamentoAtual =
                                            testesAlunos.treinamento.id;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FazerQuiz(
                                              emailUser: '_emailUser',
                                              quizID: '',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.task),
                        title: Text('Teste 2'),
                        subtitle: Text('Nota: ${testesAlunos.notaTeste2}'),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          tooltip: 'Fazer teste',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Inciar Teste 2'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Confirmar e começar teste'),
                                      onPressed: () {},
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
