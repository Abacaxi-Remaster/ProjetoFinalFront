import 'package:flutter/material.dart';
import 'package:projeto_final_front/Paginas/CrudVagas.dart';
import 'package:provider/provider.dart';
import 'all.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<List<NavigationRailDestination>> testes = [
    //Lista de possíveis barras de navegação
    [
      //Aluno
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
    ],
    [
      //Mentor
      NavigationRailDestination(
        icon: Icon(Icons.check_box),
        label: Text('Atividades Concluídas'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.event),
        label: Text('Vagas'),
      ),
    ],
    [
      //Empresa
      NavigationRailDestination(
        icon: Icon(Icons.summarize),
        label: Text('Atividades Concluídas'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.edit_calendar),
        label: Text('Criar Vagas'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.check_box),
        label: Text('Atividades Concluidas'),
      ),
    ],
    [
      //ADM
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
    ],
  ];

  Widget updatePage(selectedIndex, tipoLogado) {
    final admOptions = [
      MenuTreinamentos(),
      TestesPage(),
      VagasPage(),
      AtConcluidasMentorPage(),
    ];
    final alunoOptions = [
      TreinamentosAlunoPage(),
      Placeholder(),
      VagasAlunoPage(),
    ];
    final mentorOptions = [
      Placeholder(),
      VagasPage(),
    ];
    final empresaOptions = [
      Placeholder(),
      MenuVagas(),
      Placeholder(),
    ];
    switch (tipoLogado) {
      case 0:
        return alunoOptions[selectedIndex];
      case 1:
        return mentorOptions[selectedIndex];
      case 2:
        return empresaOptions[selectedIndex];
      case 3:
        return admOptions[selectedIndex];
    }
    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    Widget menu = Placeholder(); //menu atual
    var appState = context.watch<MyAppState>();

    return LayoutBuilder(builder: (context, constraints) {
      if (appState.logado) {
        menu = navigationMenu(constraints, appState.tipoLogado);
      } else {
        menu = EmptyMenu();
      }
      return Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            //appState.deslogar();
            //TESTES: ----------------------------------------;
            appState.TESTE_toggle_tipoLogado();
            //appState.TESTE_adm();
          },
          child: Text('Deslogar'),
        ),
        body: Row(
          children: [
            SafeArea(
              child: menu,
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: appState.page,
              ),
            ),
          ],
        ),
      );
    });
  }

  NavigationRail navigationMenu(BoxConstraints constraints, tipo) {
    var appState = context.watch<MyAppState>();
    return NavigationRail(
      extended: constraints.maxWidth >= 600,
      destinations: testes[tipo],
      selectedIndex: appState.selectedIndex,
      onDestinationSelected: (value) {
        appState.setPage(updatePage(value, appState.tipoLogado));
        setState(() {
          appState.setIndex(value);
        });
      },
    );
  }
}

class EmptyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
