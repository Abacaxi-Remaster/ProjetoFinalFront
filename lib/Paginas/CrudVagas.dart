import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../main.dart';
import '../all.dart';

class MenuVagas extends StatefulWidget {
  @override
  MenuVagasCrudState createState() => MenuVagasCrudState();
}

class MenuVagasCrudState extends State<MenuVagas> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final requisitosController = TextEditingController();
  final salarioController = TextEditingController();
  String tituloVaga = '';
  String descricao = '';
  int id = Random().nextInt(1000);
  String empresaContratando = '';
  String requisitos = '';
  int salario = 0;

  void submitForm() {
    tituloController.clear();
    descricaoController.clear();
    requisitosController.clear();
    salarioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Vagas', style: TextStyle(fontSize: 25)),
        TextFormField(
          controller: tituloController,
          decoration: InputDecoration(labelText: 'Titulo da vaga'),
          onChanged: (value) {
            setState(() {
              tituloVaga = value;
            });
          },
        ),
        TextFormField(
          controller: descricaoController,
          decoration: InputDecoration(labelText: 'Descrição'),
          onChanged: (value) {
            setState(() {
              descricao = value;
            });
          },
        ),
        TextFormField(
          controller: requisitosController,
          decoration: InputDecoration(labelText: 'Requisitos'),
          onChanged: (value) {
            setState(() {
              requisitos = value;
            });
          },
        ),
        TextFormField(
          controller: salarioController,
          decoration: InputDecoration(labelText: 'Salario'),
          onChanged: (value) {
            setState(() {
              int? integerValue = int.tryParse(salarioController.text);
              if (integerValue != null) {
                salario = integerValue;
                print("Integer value: $integerValue");
              } else {
                print("Invalid input. Please enter a valid integer.");
              }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Criar Vaga'),
                  content: TextField(
                    controller: tituloController,
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Salvar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        criaVaga(tituloVaga, descricao, 0, appState.logged.id,
                            requisitos, salario);
                        appState.adicionarVaga(Vaga(
                            tituloVaga: tituloVaga,
                            descricao: descricao,
                            id: '',
                            idEmpresaContratando: appState.logged.nome,
                            requisitos: requisitos,
                            salario: salario));
                        submitForm();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        for (var vaga in appState.vagas)
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                appState.vagaAtual = vaga;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalheVaga(),
                  ),
                );
              },
            ),
            title: Text(vaga.tituloVaga),
            subtitle: Text(vaga.descricao),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                appState.removerVaga(vaga);
              },
            ),
          ),
      ],
    );
  }
}

class VagasAlunoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FutureBuilder<List<Vaga>>(
      future: listaVagas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display an error message if data retrieval fails
        } else {
          List<Vaga>? vagas = snapshot.data;

          return ListView(
            children: [
              Text('Lista de Vagas:', style: TextStyle(fontSize: 25)),
              for (var vaga in vagas!)
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Titulo: ${vaga.tituloVaga}'),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descrição: ${vaga.descricao}'),
                            Text('Código: ${vaga.id}'),
                            Text(
                                'Empresa Contratante: ${vaga.idEmpresaContratando}'),
                            Text('Requisitos: ${vaga.requisitos}'),
                            Text('Salario: ${vaga.salario}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.add),
                          tooltip: 'Inscreva-se',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirme sua Inscrição'),
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
                                        print(vaga.id);
                                        print(appState.logged.id);
                                        criaInscricaoVaga(
                                            vaga.id, appState.logged.id);
                                        Navigator.of(context)
                                            .pop(); // Pass the appropriate values for idAluno and idVaga
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
            ],
          );
        }
      },
    );
  }
}

class VagasInscritasAlunoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Vagas Inscritas:', style: TextStyle(fontSize: 25)),
        //for (var vaga in appState.vagas)
        ListTile(
          leading: Icon(Icons.task),
          title: Text('Titulo: '),
          subtitle: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descrição: Teste'),
                    Text('Código: teste'),
                    Text('Empresa Contratante: Teste'),
                    Text('Requisitos: Teste'),
                    Text('Salario: Teste'),
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
      ],
    );
  }
}

class VagasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Lista de Vagas:', style: TextStyle(fontSize: 25)),
        for (var vaga in appState.vagas)
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Titulo: ${vaga.tituloVaga}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Descrição: ${vaga.descricao}'),
                Text('Código: ${vaga.id}'),
                Text('Empresa Contratante: ${vaga.idEmpresaContratando}'),
                Text('Requisitos: ${vaga.requisitos}'),
                Text('Vaga: ${vaga.salario}'),
              ],
            ),
          ),
      ],
    );
  }
}
