import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
  void updatePage() {}
}

class MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  List<List<NavigationRailDestination>> testes = [
    //Lista de possíveis barras de navegação
    [
      NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.favorite),
        label: Text('Favorites'),
      ),
    ],
    [
      NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.email),
        label: Text('Favorites'),
      ),
    ],
    [
      NavigationRailDestination(
        icon: Icon(Icons.label),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.email),
        label: Text('Favorites'),
      ),
    ],
    [
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
        icon: Icon(Icons.check_box),
        label: Text('Atividades Concluidas'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.logout),
        label: Text('Log out'),
      ),
    ],
  ];

  Widget logout() {
    return LoginPage();
  }

  Widget updatePage(selectedIndex, tipoLogado) {
    final admOptions = [
      MenuTreinamentos(),
      TestesPage(),
      VagasPage(),
      AtConcluidasMentorPage(),
      logout(),
    ];
    switch (tipoLogado) {
      case 0:
        switch (selectedIndex) {
          case 0:
            print('Pagina Original Aluno');
            return Placeholder();
          case 1:
            print('aluno 1');
            return CursosPage();
          default:
            break;
        }
        break;
      case 1:
        switch (selectedIndex) {
          case 0:
            print('Pagina Original Mentor');
            return LoginPage();
          case 1:
            print('mentor 1');
            return CadastroPage();
          default:
            break;
        }
        break;
      case 2:
        switch (selectedIndex) {
          case 0:
            print('Pagina Original Empresa');
            break;
          case 1:
            print('empresa 1');
            break;
          default:
            break;
        }
        break;
      case 3:
        switch (selectedIndex) {
          case 0:
            return admOptions[0];
          case 1:
            return admOptions[1];
          case 2:
            return admOptions[2];
          case 3:
            return admOptions[3];
          case 4:
            return admOptions[4];
          case 5:
            return admOptions[5];
          default:
            throw UnimplementedError('no widget for $selectedIndex');
        }
      //break;
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
          //TESTE!
          onPressed: () {
            appState.TESTE_toggle_tipoLogado();
          },
          child: Text('Próximo'),
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
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        appState.setPage(updatePage(value, appState.tipoLogado));
        setState(() {
          selectedIndex = value;
        });
      },
    );
  }
}

class EmptyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    ;
  }
}
