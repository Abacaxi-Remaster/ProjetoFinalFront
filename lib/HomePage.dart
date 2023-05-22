import 'package:flutter/material.dart';
import 'package:projeto_final_front/Login.dart';
import 'package:projeto_final_front/MenuAluno.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Widget page = Placeholder();
    Widget menu;
    List<Widget> menus = [
      EmptyMenu(),
      MenuAluno(),
    ];

    if (appState.logado) {
      page = LoginPage();
      menu = menus[0];
    } else {
      menu = menus[appState.tipo_logado];
      page = Placeholder();
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: menu,
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class EmptyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
