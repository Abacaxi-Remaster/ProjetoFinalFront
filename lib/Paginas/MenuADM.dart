import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../all.dart';

class ADM extends StatelessWidget {
  final treinamentosController = TextEditingController();
  final testesController = TextEditingController();
  final vagasController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon = Icons.check;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: treinamentosController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Treinamentos',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: testesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Testes',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: vagasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vagas',
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.addTreinamentos(treinamentosController.text);
                  appState.addTestes(testesController.text);
                  appState.addVagas(vagasController.text);
                },
                icon: Icon(icon),
                label: Text('Confirmar'),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
