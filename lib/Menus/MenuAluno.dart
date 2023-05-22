import 'package:flutter/material.dart';
import 'package:projeto_final_front/HomePage.dart';
import 'package:provider/provider.dart';
import '../all.dart';
import '../main.dart';

class MenuAluno extends StatelessWidget {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = CadastroPage();
        break;
      case 1:
        page = Placeholder();
        break;
      case 2:
        page = Placeholder();
        break;
      case 3:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return NavigationRail(
        extended: constraints.maxWidth >= 600, // ← Here.
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.menu),
            label: Text('Menu'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.folder),
            label: Text('Cursos'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.menu_book),
            label: Text('Testes'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.logout),
            label: Text('Log out'),
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {},
      );
    });
  }
}
