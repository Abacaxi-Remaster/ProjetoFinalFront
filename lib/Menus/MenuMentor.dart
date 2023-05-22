import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/main.dart';

class CursosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ListView(
      children: [
        for (var teste in appState.test)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(teste),
          ),
      ],
    );
  }
}
