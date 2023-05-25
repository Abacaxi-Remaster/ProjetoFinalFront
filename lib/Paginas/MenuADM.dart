import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'all.dart';

class ADMMenu extends StatefulWidget {
  @override
  State<ADMMenu> createState() => ADMMenuState();
}

class ADMMenuState extends State<ADMMenu> {
  var selectedIndex = 0;
  TextEditingController textController = TextEditingController();

  final widgetOptions = [
    MenuTreinamentos(),
    TestesPage(),
    VagasPage(),
    AtConcluidasMentorPage()
  ];

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = widgetOptions[0];
        break;
      case 1:
        page = widgetOptions[1];
        break;
      case 2:
        page = widgetOptions[2];
        break;
      case 3:
        page = widgetOptions[3];
        break;
      case 4:
        page = widgetOptions[4];
        break;
      case 5:
        page = widgetOptions[5];
        break;
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

class ADM extends StatelessWidget {
  final treinamentosController = TextEditingController();
  final testesController = TextEditingController();
  final vagasController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    IconData icon = Icons.check;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: treinamentosController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Treinamentos',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: testesController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Testes',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: vagasController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vagas',
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.addTreinamentos(treinamentosController.text);
                  appState.addTestes(testesController.text);
                  appState.addVagas(vagasController.text);
                },
                icon: Icon(icon),
                label: Text('Confirmar'),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
