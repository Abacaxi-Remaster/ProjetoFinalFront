import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import "../all.dart";

class DetalheVaga extends StatefulWidget {
  @override
  State<DetalheVaga> createState() => _DetalheVagaState();
}

class _DetalheVagaState extends State<DetalheVaga> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Vaga vaga = appState.vagaAtual;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(vaga.tituloVaga),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
      ),
      body: ListView(
        children: [
          for (var inscritos in appState.treinamentos) ...[
            /*ListTile(
              title: Text(treinamento.nomeComercial),
              subtitle: Text(treinamento.descricao),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  appState.removerTreinamento(treinamento);
                },
              ),
            ),
          */
          ]
        ],
      ),
    );
  }
}
