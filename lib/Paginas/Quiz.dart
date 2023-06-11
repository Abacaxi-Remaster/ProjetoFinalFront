import 'package:flutter/material.dart';
import 'package:projeto_final_front/all.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../main.dart';

class Quiz extends StatefulWidget {
  final String quizID;

  Quiz({
    required this.quizID,
  });

  @override
  QuizState createState() => QuizState();
}

class QuizState extends State<Quiz> {
  late List<GlobalKey<FormState>> _formKeys;
  @override
  void initState() {
    super.initState();
    // Move the initialization of _formKeys inside the initState method
    _formKeys =
        List.generate(salvaResp.length, (index) => GlobalKey<FormState>());
  }

  int check = 0;
  String pergunta = '';
  String respostaA = '';
  String respostaB = '';
  String respostaC = '';
  String respostaD = '';
  String respostaE = '';

  String alternativa = '';

  bool checkAlternativaA = false;
  bool checkAlternativaB = false;
  bool checkAlternativaC = false;
  bool checkAlternativaD = false;
  bool checkAlternativaE = false;

  List<Questao> salvaResp = [];
  void addResposta() {
    setState(() {
      int contaQuestao = salvaResp.length + 1;
      salvaResp.add(Questao(
        idTreinamentoQuiz: widget.quizID,
        questao: 'Questão $contaQuestao',
        pergunta: pergunta,
        alternativaCorreta: alternativa,
        respostaDaAlternativaA: respostaA,
        alternativaA: checkAlternativaA,
        respostaDaAlternativaB: respostaB,
        alternativaB: checkAlternativaB,
        respostaDaAlternativaC: respostaC,
        alternativaC: checkAlternativaC,
        respostaDaAlternativaD: respostaD,
        alternativaD: checkAlternativaD,
        respostaDaAlternativaE: respostaE,
        alternativaE: checkAlternativaE,
      ));
    });
  }

  void printRespostas(List<Questao> respostas) {
    for (int i = 0; i < respostas.length; i++) {
      Questao resposta = respostas[i];
      print('Questão: ${resposta.questao}');
      print('Pergunta: ${resposta.pergunta}');
      print('Alternativa Correta: ${resposta.alternativaCorreta}');
      print('Resposta A: ${resposta.respostaDaAlternativaA}');
      print('Alternativa A: ${resposta.alternativaA}');
      print('Resposta B: ${resposta.respostaDaAlternativaB}');
      print('Alternativa B: ${resposta.alternativaB}');
      print('Resposta C: ${resposta.respostaDaAlternativaC}');
      print('Alternativa C: ${resposta.alternativaC}');
      print('Resposta D: ${resposta.respostaDaAlternativaD}');
      print('Alternativa D: ${resposta.alternativaD}');
      print('Resposta E: ${resposta.respostaDaAlternativaE}');
      print('Alternativa E: ${resposta.alternativaE}');
      print('ID do Treinamento Quiz: ${resposta.idTreinamentoQuiz}');
      print('---');
    }
  }

  int salvaIndex = 0;
  int contaQuestao = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    Form returnCheckbox(index, listaRespostas) {
      checkAlternativaA = false;
      checkAlternativaB = false;
      checkAlternativaC = false;
      checkAlternativaD = false;
      checkAlternativaE = false;

      respostaA = '';
      respostaB = '';
      respostaC = '';
      respostaD = '';
      respostaE = '';

      return Form(
        key: _formKeys[index],
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                return validaNullClean(value);
              },
              onChanged: (text) {
                listaRespostas[index].pergunta = text;
                pergunta = listaRespostas[index].pergunta;
              },
              decoration: InputDecoration(
                labelText: 'Pergunta',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                return validaNullClean(value);
              },
              onChanged: (text) {
                listaRespostas[index].respostaDaAlternativaA = text;
                respostaA = listaRespostas[index].respostaDaAlternativaA;
              },
              decoration: InputDecoration(
                labelText: 'Resposta A',
              ),
            ),
            CheckboxListTile(
              value: listaRespostas[index].alternativaA,
              onChanged: (bool? value) {
                setState(() {
                  listaRespostas[index].alternativaA = value!;
                  //checkAlternativaA = listaRespostas[index].alternativaA;
                  listaRespostas[index].alternativaB = false;
                  listaRespostas[index].alternativaC = false;
                  listaRespostas[index].alternativaD = false;
                  listaRespostas[index].alternativaE = false;
                  if (value) {
                    listaRespostas[index].alternativaCorreta = 'A';
                    check++;
                  } else {
                    listaRespostas[index].alternativaCorreta = '';
                    check--;
                  }
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                return validaNullClean(value);
              },
              onChanged: (text) {
                listaRespostas[index].respostaDaAlternativaB = text;
                respostaB = listaRespostas[index].respostaDaAlternativaB;
              },
              decoration: InputDecoration(
                labelText: 'Resposta B',
              ),
            ),
            CheckboxListTile(
              value: listaRespostas[index].alternativaB,
              onChanged: (bool? value) {
                setState(() {
                  listaRespostas[index].alternativaB = value!;
                  //checkAlternativaB = listaRespostas[index].alternativaB;
                  listaRespostas[index].alternativaA = false;
                  listaRespostas[index].alternativaC = false;
                  listaRespostas[index].alternativaD = false;
                  listaRespostas[index].alternativaE = false;
                  if (value) {
                    listaRespostas[index].alternativaCorreta = 'B';
                    check++;
                  } else {
                    listaRespostas[index].alternativaCorreta = '';
                    check--;
                  }
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                return validaNullClean(value);
              },
              onChanged: (text) {
                listaRespostas[index].respostaDaAlternativaC = text;
                respostaC = listaRespostas[index].respostaDaAlternativaC;
              },
              decoration: InputDecoration(
                labelText: 'Resposta C',
              ),
            ),
            CheckboxListTile(
              value: listaRespostas[index].alternativaC,
              onChanged: (bool? value) {
                setState(() {
                  listaRespostas[index].alternativaC = value!;
                  //checkAlternativaC = listaRespostas[index].alternativaC;
                  listaRespostas[index].alternativaA = false;
                  listaRespostas[index].alternativaB = false;
                  listaRespostas[index].alternativaD = false;
                  listaRespostas[index].alternativaE = false;
                  if (value) {
                    listaRespostas[index].alternativaCorreta = 'C';
                    check++;
                  } else {
                    listaRespostas[index].alternativaCorreta = '';
                    check--;
                  }
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                return validaNullClean(value);
              },
              onChanged: (text) {
                listaRespostas[index].respostaDaAlternativaD = text;
                respostaD = listaRespostas[index].respostaDaAlternativaD;
              },
              decoration: InputDecoration(
                labelText: 'Resposta D',
              ),
            ),
            CheckboxListTile(
              value: listaRespostas[index].alternativaD,
              onChanged: (bool? value) {
                setState(() {
                  listaRespostas[index].alternativaD = value!;
                  //checkAlternativaD = listaRespostas[index].alternativaD;
                  listaRespostas[index].alternativaA = false;
                  listaRespostas[index].alternativaB = false;
                  listaRespostas[index].alternativaC = false;
                  listaRespostas[index].alternativaE = false;
                  if (value) {
                    listaRespostas[index].alternativaCorreta = 'D';
                    check++;
                  } else {
                    listaRespostas[index].alternativaCorreta = '';
                    check--;
                  }
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                return validaNullClean(value);
              },
              onChanged: (text) {
                listaRespostas[index].respostaDaAlternativaE = text;
                respostaE = listaRespostas[index].respostaDaAlternativaE;
              },
              decoration: InputDecoration(
                labelText: 'Resposta E',
              ),
            ),
            CheckboxListTile(
              value: listaRespostas[index].alternativaE,
              onChanged: (bool? value) {
                setState(() {
                  listaRespostas[index].alternativaE = value!;
                  //checkAlternativaE = listaRespostas[index].alternativaE;
                  listaRespostas[index].alternativaA = false;
                  listaRespostas[index].alternativaB = false;
                  listaRespostas[index].alternativaC = false;
                  listaRespostas[index].alternativaD = false;
                  if (value) {
                    listaRespostas[index].alternativaCorreta = 'E';
                    check++;
                  } else {
                    listaRespostas[index].alternativaCorreta = '';
                    check--;
                  }
                });
              },
              title: Text('Selecionar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        titleTextStyle: style,
      ),
      body: ListView.builder(
        itemCount: salvaResp.length,
        itemBuilder: (context, index) {
          salvaIndex = index;
          return Column(
            children: [
              ListTile(
                title: Text(salvaResp[index].questao, style: style),
              ),
              returnCheckbox(index, salvaResp),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 110.0),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FloatingActionButton(
                onPressed: () {
                  addResposta();
                  _formKeys.add(GlobalKey<FormState>());
                  contaQuestao++;
                },
                child: Text('NOVO', style: TextStyle(fontSize: 20)),
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 58,
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                child: ButtonTheme(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onPressed: () {
                      //Funcao para mandar questão para o banco de dados passando salvaResp
                      if (salvaResp.length >= 3) {
                        /*if (_formKeys.every((key) =>
                            key.currentState != null &&
                            key.currentState!.validate())) {
                          */
                        if (check == salvaResp.length) {
                          appState.addQuiz(salvaResp);
                          Navigator.of(context).pop();
                        } else {
                          appState.erro(
                              'Erro no Cadastro - Assinale a alternativa correta em todas as perguntas!');
                        }
                        /*} else {
                          appState.erro(
                              'Erro no Cadastro - Preencha todos os Campos!');
                        }*/
                      } else {
                        appState
                            .erro('Erro no Cadastro - mínimo de 3 perguntas!');
                      }
                    },
                    child: Text(
                      "Enviar quiz",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}

class Questao {
  String questao;
  String pergunta;

  String respostaDaAlternativaA;
  String respostaDaAlternativaB;
  String respostaDaAlternativaC;
  String respostaDaAlternativaD;
  String respostaDaAlternativaE;
  String alternativaCorreta;

  bool alternativaA;
  bool alternativaB;
  bool alternativaC;
  bool alternativaD;
  bool alternativaE;
  String idTreinamentoQuiz;

  Questao({
    required this.idTreinamentoQuiz,
    required this.questao,
    required this.pergunta,
    required this.respostaDaAlternativaA,
    required this.alternativaA,
    required this.respostaDaAlternativaB,
    required this.alternativaB,
    required this.respostaDaAlternativaC,
    required this.alternativaC,
    required this.respostaDaAlternativaD,
    required this.alternativaD,
    required this.respostaDaAlternativaE,
    required this.alternativaE,
    required this.alternativaCorreta,
  });

  Map<String, dynamic> toJson() {
    return {
      "enunciado": pergunta,
      "resposta": alternativaCorreta,
      "opcao_a": respostaDaAlternativaA,
      "opcao_b": respostaDaAlternativaB,
      "opcao_c": respostaDaAlternativaC,
      "opcao_d": respostaDaAlternativaD,
      "opcao_e": respostaDaAlternativaE,
    };
  }
}
