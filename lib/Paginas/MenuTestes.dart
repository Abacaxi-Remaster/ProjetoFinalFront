import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../main.dart';
import '../all.dart';

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

  return FutureBuilder<List<Treinamento>>(
    future: listaTreinamentosAluno(appState.logged.id),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Display a loading indicator while fetching data
      } else if (snapshot.hasError) {
        return Text(
          'Error: ${snapshot.error}',
        ); // Display an error message if data retrieval fails
      } else {
        List<Treinamento>? treinamentos = snapshot.data;
        
        return ListView(
          children: [
            Text('Atividades Concluídas', style: TextStyle(fontSize: 25)),
            // for (var testesAlunos in appState.teste)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 1'),
                children: [
                  for (var treinamento in treinamentos!)
                    ListTile(
                      leading: Icon(Icons.task),
                      title: Text(treinamento.nomeComercial),
                      subtitle: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Descrição: ${treinamento.descricao}'),
                                Text(
                                    'Empresa Contratante: ${treinamento.cargaHoraria}'),
                                Text('Código: ${treinamento.id}'),
                                Text('Mínimo de cadndidatos: ${treinamento.minCandidatos}'),
                                Text('Máximo de cadndidatos: ${treinamento.maxCandidatos}'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.not_interested),
                              tooltip: 'Desinscreva-se',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Cancelar Inscrição'),
                                      actions: [
                                        TextButton(
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Confirmar'),
                                          onPressed: () {
                                            //remover aluno efetivamente!
                                            Navigator.of(context).pop();
                                          },
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
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
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
                                  onPressed: () {},
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
                    subtitle: Text('Nota: 0'),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionTile(
                title: Text('Treinamento 2'),
                children: [
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Teste 1'),
                    subtitle: Text('Nota: 0'),
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
                                    //chamar
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
                    subtitle: Text('Nota: 0'),
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
