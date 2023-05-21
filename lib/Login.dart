import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                validator: MultiValidator([
                  RequiredValidator(errorText: "* Required"),
                  EmailValidator(
                      errorText: "Insira um endereço de email válido!"),
                ]),
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
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                //substituir por envio para API
                appState.addTest(userController.text);
                appState.addTest(passwordController.text);
              },
              child: Text('Próximo'),
            ),
            TextButton(
              onPressed: () {},
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
