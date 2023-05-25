import 'package:flutter/material.dart';
import 'package:projeto_final_front/HomePage.dart';
import 'package:projeto_final_front/all.dart';
import 'package:provider/provider.dart';
import '/main.dart';

class LoginPage extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        width: 400,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Text('LOGIN'),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: userController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //substituir por envio para API
                appState.addTest(userController.text);
                appState.addTest(passwordController.text);
                appState.TESTE_toggle_logado();
                print(appState.logado);
                //fim da substituição
                appState.setPage(
                    MyHomePageState().updatePage(0, appState.tipoLogado));
              },
              child: Text('Próximo'),
            ),
            TextButton(
              onPressed: () {
                appState.setPage(CadastroPage());
                print('setou');
              },
              child: Text(
                'Sign Up',
              ),
            )
          ],
        ),
      ),
    );
  }
}
