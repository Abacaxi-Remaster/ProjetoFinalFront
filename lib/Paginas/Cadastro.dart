import 'package:flutter/material.dart';
import 'package:projeto_final_front/all.dart';
import 'package:provider/provider.dart';
import '/main.dart';

const List<Widget> Tipos = <Widget>[
  Text('Aluno'),
  Text('Mentor'),
  Text('Empresa'),
];

class CadastroPage extends StatefulWidget {
  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<bool> _tipoCadastrado = <bool>[true, false, false];
  var tipoSelecionado = 0;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomeController = TextEditingController();
  final ultimoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var labelFinal;

    switch (tipoSelecionado) {
      case 0:
        labelFinal = 'Curso';
        break;
      case 1:
        labelFinal = 'CPF';
        break;
      case 2:
        labelFinal = 'CNPJ';
        break;
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 250),
        child: Container(
          padding: EdgeInsets.all(12.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Text('Cadastro'),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _tipoCadastrado.length; i++) {
                        _tipoCadastrado[i] = i == index;
                      }
                      tipoSelecionado = index;
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _tipoCadastrado,
                  children: Tipos,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: nomeController,
                    validator: (value) {
                      return validaNull(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome Completo',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      return validaNull(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      return validaNull(value);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: ultimoController,
                    validator: (value) {
                      return validaNull(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: labelFinal,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //adicionar confirmação de inputs
                    if (_formKey.currentState!.validate()) {
                      cadastro(
                          tipoSelecionado,
                          nomeController.text,
                          emailController.text,
                          passwordController.text,
                          ultimoController.text);
                      appState.setPage(LoginPage());
                    }
                  },
                  child: Text('Cadastrar'),
                ),
                TextButton(
                  onPressed: () {
                    appState.setPage(LoginPage());
                  },
                  child: Text(
                    'voltar para o Login',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
