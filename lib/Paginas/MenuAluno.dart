import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class Aluno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon = Icons.favorite;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(icon),
                label: Text('Informações'),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
