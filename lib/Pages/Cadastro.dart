import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/main.dart';

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
              Row(
                children: [
                  //botões de tipo
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  //controller: userController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome Completo',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  //controller: userController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  //controller: userController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  //controller: userController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar Senha',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  //controller: userController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rever este espaço!',
                  ),
                ),
              ),
              //Botão de enviar
              //retorno para o login (?)
            ],
          ),
        ),
      ),
    );
  }
}
