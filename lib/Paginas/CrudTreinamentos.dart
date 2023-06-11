import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../main.dart';
import 'Quiz.dart';
import '../all.dart';
import 'FazerQuiz.dart';

class MenuTreinamentos extends StatefulWidget {
  @override
  MenuTreinamentosCrudState createState() => MenuTreinamentosCrudState();
}

class MenuTreinamentosCrudState extends State<MenuTreinamentos> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nomeComercialController = TextEditingController();
  final descricaoController = TextEditingController();
  final cargaHorariaController = TextEditingController();
  final qtdMinInscritosController = TextEditingController();
  final qtdMaxInscritosController = TextEditingController();
  final fieldText = TextEditingController();

  String nomeComercial = '';
  String descricao = '';
  int cargaHoraria = 0;
  String codigo = 'Random().nextInt(1000)';
  int minCandidatos = 0;
  int maxCandidatos = 0;
  DateTime dataInicialInscricao = DateTime.now();
  DateTime dataFinalInscricao = DateTime.now();
  DateTime dataInicialTreinamento = DateTime.now();
  DateTime dataFinalTreinamento = DateTime.now();

  TextInputFormatter _inputFormatter = FilteringTextInputFormatter.digitsOnly;

  void submitForm() {
    nomeComercialController.clear();
    descricaoController.clear();
    cargaHorariaController.clear();
    qtdMinInscritosController.clear();
    qtdMaxInscritosController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: ListView(
        children: [
          Text('Treinamentos', style: TextStyle(fontSize: 25)),
          TextFormField(
            controller: nomeComercialController,
            validator: (value) {
              return validaNull(value);
            },
            decoration: InputDecoration(labelText: 'Nome Comercial'),
            onChanged: (value) {
              setState(() {
                nomeComercial = value;
              });
            },
          ),
          TextFormField(
            controller: descricaoController,
            validator: (value) {
              return validaNull(value);
            },
            decoration: InputDecoration(labelText: 'Descrição'),
            onChanged: (value) {
              setState(() {
                descricao = value;
              });
            },
          ),
          TextFormField(
            controller: cargaHorariaController,
            validator: (value) {
              return validaNull(value);
            },
            inputFormatters: [_inputFormatter],
            decoration: InputDecoration(labelText: 'Carga Horária'),
            onChanged: (value) {
              setState(() {
                maxCandidatos = int.tryParse(value) ?? 0;
              });
            },
          ),
          TextFormField(
            controller: qtdMinInscritosController,
            validator: (value) {
              return validaNull(value);
            },
            inputFormatters: [_inputFormatter],
            decoration:
                InputDecoration(labelText: 'Quantidade Mínima de Inscritos'),
            onChanged: (value) {
              setState(() {
                maxCandidatos = int.tryParse(value) ?? 0;
              });
            },
          ),
          TextFormField(
            controller: qtdMaxInscritosController,
            validator: (value) {
              return validaNull(value);
            },
            inputFormatters: [_inputFormatter],
            decoration:
                InputDecoration(labelText: 'Quantidade Máxima de Inscritos'),
            onChanged: (value) {
              setState(() {
                maxCandidatos = int.tryParse(value) ?? 0;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Quiz(
                    quizID: '',
                  ),
                ),
              );
            },
            child: Text('Criar Quiz'),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Criar Treinamento'),
                    content: TextField(
                      controller: nomeComercialController,
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Salvar'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (appState.Quizzes.length == 2) {
                              Navigator.of(context).pop();
                              criaTreinamento(
                                  Treinamento(
                                    nomeComercial: nomeComercial,
                                    descricao: descricao,
                                    cargaHoraria: cargaHoraria,
                                    codigo: codigo,
                                    minCandidatos: minCandidatos,
                                    maxCandidatos: maxCandidatos,
                                    dataInicialInscricao: dataInicialInscricao,
                                    dataFinalInscricao: dataFinalInscricao,
                                    dataInicialTreinamento:
                                        dataInicialTreinamento,
                                    dataFinalTreinamento: dataFinalTreinamento,
                                  ),
                                  appState.Quizzes);
                              submitForm();
                              appState.clearQuizzes();
                            } else {
                              appState.erro(
                                  'Erro no Cadastro - Insira 3 Quiz no total!');
                            }
                          } else {
                            appState.erro(
                                'Erro no Cadastro - Preencha os Campos Obrigatórios!');
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          for (var quiz in appState.Quizzes) ...[
            ListTile(
              leading: Icon(Icons.check),
              title: Text(quiz.Nome),
            ),
          ],
        ],
      ),
    );
  }
}

class TreinamentosAlunoPage extends StatelessWidget {
  final TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  int index = 0;
  List<dynamic> dataListCursosBD = [];
  String _emailUser = '';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    String idAluno = '0';
    String idTreinamento = '0';

    void criarInscritoTreinamento() {
      InscritoVaga inscrito = InscritoVaga(
        idAluno: idAluno,
        idVaga: idTreinamento,
      );

      /*var appState = context.watch<MyAppState>();
      appState.adicionarInscrito(inscrito);*/
    }

    return FutureBuilder<List<Treinamento>>(
      future: listaTreinamentos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display an error message if data retrieval fails
        } else {
          List<Treinamento>? treinamentos = snapshot.data;

          return ListView(
            children: [
              Text('Lista de Treinamentos:', style: TextStyle(fontSize: 25)),
              for (var treinamento in treinamentos!)
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Titulo: ${treinamento.nomeComercial}'),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descrição: ${treinamento.descricao}'),
                            Text('Carga Horária: ${treinamento.cargaHoraria}'),
                            Text('Código: ${treinamento.codigo}'),
                            Text(
                                'Mínimo de Candidatos: ${treinamento.minCandidatos}'),
                            Text(
                                'Máximo de Candidatos: ${treinamento.maxCandidatos}'),
                            Text(
                                'Data Inicial de Inscrição: ${DateFormat('dd/MM/yyyy').format(treinamento.dataInicialInscricao)}'),
                            Text(
                                'Data Final de Inscrição: ${DateFormat('dd/MM/yyyy').format(treinamento.dataFinalInscricao)}'),
                            Text(
                                'Data Inicial do Treinamento: ${DateFormat('dd/MM/yyyy').format(treinamento.dataInicialTreinamento)}'),
                            Text(
                                'Data Final do Treinamento: ${DateFormat('dd/MM/yyyy').format(treinamento.dataFinalTreinamento)}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.add),
                          tooltip: 'Inscreva-se',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirme sua Inscrição'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Confirmar e começar quiz'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        appState.adicionarInscrito(InscritoVaga(
                                          idAluno: idAluno,
                                          idVaga: idTreinamento,
                                        ));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FazerQuiz(
                                              emailUser: _emailUser,
                                              quizID: '',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}

class TreinamentosADMPage extends StatelessWidget {
  final TextStyle style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  int index = 0;
  List<dynamic> dataListCursosBD = [];
  String _emailUser = '';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    String idAluno = '0';
    String idTreinamento = '0';

    void criarInscritoTreinamento() {
      InscritoVaga inscrito = InscritoVaga(
        idAluno: idAluno,
        idVaga: idTreinamento,
      );

      /*var appState = context.watch<MyAppState>();
      appState.adicionarInscrito(inscrito);*/
    }

    return FutureBuilder<List<Treinamento>>(
      future: listaTreinamentos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display an error message if data retrieval fails
        } else {
          List<Treinamento>? treinamentos = snapshot.data;

          return ListView(
            children: [
              Text('Lista de Treinamentos:', style: TextStyle(fontSize: 25)),
              for (var treinamento in treinamentos!)
                ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Titulo: ${treinamento.nomeComercial}'),
                  subtitle: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descrição: ${treinamento.descricao}'),
                            Text('Carga Horária: ${treinamento.cargaHoraria}'),
                            Text('Código: ${treinamento.codigo}'),
                            Text(
                                'Mínimo de Candidatos: ${treinamento.minCandidatos}'),
                            Text(
                                'Máximo de Candidatos: ${treinamento.maxCandidatos}'),
                            Text(
                                'Data Inicial de Inscrição: ${DateFormat('dd/MM/yyyy').format(treinamento.dataInicialInscricao)}'),
                            Text(
                                'Data Final de Inscrição: ${DateFormat('dd/MM/yyyy').format(treinamento.dataFinalInscricao)}'),
                            Text(
                                'Data Inicial do Treinamento: ${DateFormat('dd/MM/yyyy').format(treinamento.dataInicialTreinamento)}'),
                            Text(
                                'Data Final do Treinamento: ${DateFormat('dd/MM/yyyy').format(treinamento.dataFinalTreinamento)}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          tooltip: 'Detalhes',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
