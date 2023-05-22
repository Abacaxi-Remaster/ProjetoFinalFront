import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 250),
        child: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Text('Cadastro'),

              //Espaço de nome
              //Espaço de email
              //Espaço de senha
              //Espaço de confirmar senha
              //Espaço dependendo do tipo
              //Botão de enviar
              //retorno para o login (?)
            ],
          ),
        ),
      ),
    );
  }
}
