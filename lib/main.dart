import 'package:flutter/material.dart';
import 'package:projeto_final_front/Paginas/CrudVagas.dart';
import 'package:projeto_final_front/all.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';
import 'package:provider/provider.dart';
import 'package:projeto_final_front/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Projeto Final',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 3, 169, 244),
          ),
        ),
        home: Builder(
          builder: (context) {
            var appState = context.watch<MyAppState>();
            appState.scaffoldMessenger = ScaffoldMessenger.of(context);
            return MyHomePage();
          },
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  late ScaffoldMessengerState scaffoldMessenger;
  var selectedIndex = 0;
  Widget page = LoginPage();
  var test = <String>[];
  var logado = false;
  var tipoLogado = 0;
  LoggedUser logged = LoggedUser(-1, 'email', 'senha', 'nome', 'id');

  void logar(LoggedUser user) {
    if (user.tipo == 204) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Crendenciais Inválidas!'),
        ),
      );
    } else {
      logged = user;
      logado = true;
      tipoLogado = user.tipo;
      notifyListeners();
    }
  }

  void deslogar() {
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    tipoLogado = 0;
    logado = false;
    page = LoginPage();
    selectedIndex = 0;
    print('delogou');
    notifyListeners();
    //deletar dados temporarios do usuário
    //});
  }

  void erro(String mensagem) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  void setPage(Widget newPage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      page = newPage;
      //print('page: ');
      //print(page);
      notifyListeners();
    });
  }

  void setIndex(int newIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedIndex = newIndex;
      notifyListeners();
    });
  }

  List<Treinamento> _treinamentos = [];

  List<Treinamento> get treinamentos => _treinamentos;

  List<Vaga> _vagas = [];
  List<Vaga> get vagas => _vagas;

  List<Inscrito> _inscritos = [];
  List<Inscrito> get inscritos => _inscritos;

  void adicionarTreinamento(Treinamento treinamento) {
    _treinamentos.add(treinamento);
    notifyListeners();
    print(treinamento);
  }

  void removerTreinamento(Treinamento treinamento) {
    treinamentos.remove(treinamento);
    notifyListeners();
  }

  void adicionarVaga(Vaga vaga) {
    _vagas.add(vaga);
    notifyListeners();
    print(vaga);
  }

  void adicionarInscrito(Inscrito inscrito) {
    _inscritos.add(inscrito);
    notifyListeners();
    print(inscrito);
  }

  void TESTE_toggle_logado() {
    logado = !logado;
    notifyListeners();
  }

  void TESTE_toggle_tipoLogado() {
    setIndex(0);
    tipoLogado = (tipoLogado + 1) % 4;
    print(tipoLogado);
    notifyListeners();
  }

  void TESTE_adm() {
    setIndex(0);
    tipoLogado = 3;
    notifyListeners();
  }

  var treinar = <String>[];
  void addTreinamentos(String treinamentosAlunos) {
    treinar.add(treinamentosAlunos);
  }

  var teste = <String>[];
  void addTestes(String testesAlunos) {
    teste.add(testesAlunos);
    notifyListeners();
  }

  var vaga = <String>[];
  void addVagas(String vagasAlunos) {
    vaga.add(vagasAlunos);
  }
}
