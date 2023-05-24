import 'package:flutter/material.dart';
import 'package:projeto_final_front/all.dart';
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
  Widget page = LoginPage();
  var test = <String>[];
  var logado = false;
  var tipoLogado = 0;

  void setPage(Widget newPage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      page = newPage;
      print('page: ');
      print(page);
      notifyListeners();
    });
  }

  void addTest(String teste) {
    test.add(teste);
  }

  void TESTE_toggle_logado() {
    logado = !logado;
    notifyListeners();
  }

  void TESTE_toggle_tipoLogado() {
    tipoLogado = (tipoLogado + 1) % 4;
    print(tipoLogado);
    notifyListeners();
  }
}
