import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../main.dart';

class Quiz extends StatefulWidget {
  final int quizID;

  Quiz({
    required this.quizID,
  });

  @override
  QuizState createState() => QuizState();
}

class QuizState extends State<Quiz> {
  String pergunta = '';
  String respostaA = '';
  String respostaB = '';
  String respostaC = '';
  String respostaD = '';
  String respostaE = '';

  bool checkAlternativaA = false;
  bool checkAlternativaB = false;
  bool checkAlternativaC = false;
  bool checkAlternativaD = false;
  bool checkAlternativaE = false;

  List<Respostas> salvaResp = [];
  void addResposta() {
    setState(() {
      int questionCount = salvaResp.length + 1;
      salvaResp.add(Respostas(
        idTreinamentoQuiz: widget.quizID,
        questao: 'Questão $questionCount',
        pergunta: pergunta,
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

  void printRespostas(List<Respostas> respostas) {
  for (int i = 0; i < respostas.length; i++) {
    Respostas resposta = respostas[i];
    print('Questão: ${resposta.questao}');
    print('Pergunta: ${resposta.pergunta}');
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

  int salvaIndex= 0;
  int contaQuestao = 0;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    Column returnCheckbox(index, listAnswers) {
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

      return Column(
          children: [
            TextField(
              onChanged: (text) {
                listAnswers[index].pergunta = text;
                pergunta = listAnswers[index].pergunta;
              },
              decoration: InputDecoration(
                labelText: 'Pergunta',
              ),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              value: listAnswers[index].alternativaA,
              onChanged: (bool? value) {
                setState(() {
                  listAnswers[index].alternativaA = value!;
                  checkAlternativaA = listAnswers[index].alternativaA;
                  listAnswers[index].alternativaB = false;
                  listAnswers[index].alternativaC = false;
                  listAnswers[index].alternativaD = false;
                  listAnswers[index].alternativaE = false;
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (text) {
                listAnswers[index].respostaDaAlternativaA = text;
                respostaA = listAnswers[index].respostaDaAlternativaA;
              },
              decoration: InputDecoration(
                labelText: 'Resposta A',
              ),
            ),
            CheckboxListTile(
              value: listAnswers[index].alternativaB,
              onChanged: (bool? value) {
                setState(() {
                  listAnswers[index].alternativaB = value!;
                  checkAlternativaB = listAnswers[index].alternativaB;
                  listAnswers[index].alternativaA = false;
                  listAnswers[index].alternativaC = false;
                  listAnswers[index].alternativaD = false;
                  listAnswers[index].alternativaE = false;
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (text) {
                listAnswers[index].respostaDaAlternativaB = text;
                respostaB = listAnswers[index].respostaDaAlternativaB;
              },
              decoration: InputDecoration(
                labelText: 'Resposta B',
              ),
            ),
            CheckboxListTile(
              value: listAnswers[index].alternativaC,
              onChanged: (bool? value) {
                setState(() {
                  listAnswers[index].alternativaC = value!;
                  checkAlternativaC = listAnswers[index].alternativaC;
                  listAnswers[index].alternativaA = false;
                  listAnswers[index].alternativaB = false;
                  listAnswers[index].alternativaD = false;
                  listAnswers[index].alternativaE = false;
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (text) {
                listAnswers[index].respostaDaAlternativaC = text;
                respostaC = listAnswers[index].respostaDaAlternativaC;
              },
              decoration: InputDecoration(
                labelText: 'Resposta C',
              ),
            ),
            CheckboxListTile(
              value: listAnswers[index].alternativaD,
              onChanged: (bool? value) {
                setState(() {
                  listAnswers[index].alternativaD = value!;
                  checkAlternativaD = listAnswers[index].alternativaD;
                  listAnswers[index].alternativaA = false;
                  listAnswers[index].alternativaB = false;
                  listAnswers[index].alternativaC = false;
                  listAnswers[index].alternativaE = false;
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (text) {
                listAnswers[index].respostaDaAlternativaD = text;
                respostaD = listAnswers[index].respostaDaAlternativaD;
              },
              decoration: InputDecoration(
                labelText: 'Resposta D',
              ),
            ),
            CheckboxListTile(
              value: listAnswers[index].alternativaE,
              onChanged: (bool? value) {
                setState(() {
                  listAnswers[index].alternativaE = value!;
                  checkAlternativaE = listAnswers[index].alternativaE;
                  listAnswers[index].alternativaA = false;
                  listAnswers[index].alternativaB = false;
                  listAnswers[index].alternativaC = false;
                  listAnswers[index].alternativaD = false;
                });
              },
              title: Text('Selecionar'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (text) {
                listAnswers[index].respostaDaAlternativaE = text;
                respostaE = listAnswers[index].respostaDaAlternativaE;
              },
              decoration: InputDecoration(
                labelText: 'Resposta E',
              ),
            ),            
          ],
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
            Row(mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                FloatingActionButton(
                  onPressed: () {
                      addResposta();
                      contaQuestao++;
                  },
                  child: Text('NOVO', style: TextStyle(fontSize: 20)),
                ),
              ]),
              SizedBox(height: 5,),
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
                        printRespostas(salvaResp);
                        Navigator.of(context).pop();
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


class Respostas {
  String questao;
  String pergunta;

  String respostaDaAlternativaA;
  String respostaDaAlternativaB;
  String respostaDaAlternativaC;
  String respostaDaAlternativaD;
  String respostaDaAlternativaE;

  bool alternativaA;
  bool alternativaB;
  bool alternativaC;
  bool alternativaD;
  bool alternativaE;
  bool correta = true;
  int idTreinamentoQuiz;

  Respostas({
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
    
  });
}