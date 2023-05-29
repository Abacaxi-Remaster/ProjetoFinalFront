import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../main.dart';

class MenuVagas extends StatefulWidget {
  @override
  MenuVagasCrudState createState() => MenuVagasCrudState();
}

class Vaga {
  String tituloVaga;
  String descricao;
  int id;
  String empresaContratando;
  String requisitos;
  String salario;

  Vaga(
      {required this.tituloVaga,
      required this.descricao,
      required this.id,
      required this.empresaContratando,
      required this.requisitos,
      required this.salario});

  @override
  String toString() {
    return 'Vaga: '
        'tituloVaga=$tituloVaga, '
        'descricao=$descricao, '
        'id=$id, '
        'empresaContratando=$empresaContratando, '
        'requisitos=$requisitos, '
        'salario=$salario';
  }
}

class MenuVagasCrudState extends State<MenuVagas> {
  final VagasController = TextEditingController();
  String tituloVaga = '';
  String descricao = '';
  int id = Random().nextInt(1000);
  String empresaContratando = '';
  String requisitos = '';
  String salario = '';

  void criarVaga() {
    Vaga vaga = Vaga(
      tituloVaga: tituloVaga,
      descricao: descricao,
      id: id,
      empresaContratando: empresaContratando,
      requisitos: requisitos,
      salario: salario,
    );

    var appState = context.watch<MyAppState>();
    appState.adicionarVaga(vaga);
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        Text('Vagas', style: TextStyle(fontSize: 25)),
        TextFormField(
          controller: VagasController,
          decoration: InputDecoration(labelText: 'Titulo da vaga'),
          onChanged: (value) {
            setState(() {
              tituloVaga = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Descrição'),
          onChanged: (value) {
            setState(() {
              descricao = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText:
                  '-Mudar para automaticamente colocar a empresa logada-'),
          onChanged: (value) {
            setState(() {
              empresaContratando = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Requisitos'),
          onChanged: (value) {
            setState(() {
              requisitos = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Salario'),
          onChanged: (value) {
            setState(() {
              salario = value;
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
                    controller: VagasController,
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
                        appState.adicionarVaga(Vaga(
                            tituloVaga: tituloVaga,
                            descricao: descricao,
                            id: id,
                            empresaContratando: empresaContratando,
                            requisitos: requisitos,
                            salario: salario));
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
            leading: Icon(Icons.task),
            title: Text(vaga.tituloVaga),
          ),
      ],
    );
  }
}

class VagasAlunoPage extends StatelessWidget {
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
                Text('Empresa Contratante: ${vaga.empresaContratando}'),
                Text('Requisitos: ${vaga.requisitos}'),
                Text('Vaga: ${vaga.salario}'),
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
                Text('Empresa Contratante: ${vaga.empresaContratando}'),
                Text('Requisitos: ${vaga.requisitos}'),
                Text('Vaga: ${vaga.salario}'),
              ],
            ),
          ),
      ],
    );
  }
}
