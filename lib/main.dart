import 'package:flutter/material.dart';
import 'package:projeto_final_front/MenuAluno.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Projeto Final',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var test = <String>[];

  void addTest(String teste) {
    test.add(teste);
  }

  var logado = false;
  var tipo_logado = 0;
}
