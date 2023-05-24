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
        icon: Icon(Icons.home),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.sim_card_alert),
        label: Text('Favorites'),
      ),
    ],
  ];

  Widget updatePage(selectedIndex) {
    var tipoLogado = MyAppState().tipoLogado;
    switch (tipoLogado) {
      case 0:
        switch (selectedIndex) {
          case 0:
            print('Pagina Original Aluno');
            return LoginPage();
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
            break;
          case 1:
            print('mentor 1');
            break;
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
            print('Pagina Original ADM');
            break;
          case 1:
            print('adm 1');
            break;
          default:
            break;
        }
        break;
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
        appState.setPage(updatePage(selectedIndex));
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
