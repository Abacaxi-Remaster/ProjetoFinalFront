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

  List<Treinamento> _treinamentos = [];

  List<Treinamento> get treinamentos => _treinamentos;

  void adicionarTreinamento(Treinamento treinamento) {
    _treinamentos.add(treinamento);
    notifyListeners();
    print(treinamento);
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

/*class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
*/
/*class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Aluno();
        break;
      case 1:
        page = TreinamentosAlunoPage();
        break;
      case 2:
        page = TestesPage();
        break;
      case 3:
        page = VagasPage();
        break;
      case 4:
        page = ADMMenu();
        break;
      case 5:
        page = AtConcluidasMentorPage();
        break;
      /*case 6:
        page = CursosCall();
        break;*/
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600, // ← Here.
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.menu),
                    label: Text('Menu'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.folder),
                    label: Text('Treinamentos'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.menu_book),
                    label: Text('Testes'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.event),
                    label: Text('Vagas'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.logout),
                    label: Text('AdmTeste'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.check_box),
                    label: Text('Atividades Concluidas'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.check),
                    label: Text('Cursos'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
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
*/