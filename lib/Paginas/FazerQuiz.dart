import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_final_front/Paginas/Quiz.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:core';
import '../main.dart';
import "../all.dart";

import 'package:projeto_final_front/all.dart';

class FazerQuiz extends StatefulWidget {
  final String emailUser;
  final String quizID;

  const FazerQuiz({required this.emailUser, required this.quizID});

  @override
  FazerQuizState createState() => FazerQuizState();
}

class FazerQuizState extends State<FazerQuiz> {
  String quizID = '';
  String emailUser = '';
  List<Questao> ListQuestoesBD = []; //recebe os valores do bd
  Map<int, String> listaRespostasMarcada =
      {}; //receber o valor que a pessoa respondeu
  bool alternativaA = false;
  bool alternativaB = false;
  bool alternativaC = false;
  bool alternativaD = false;
  bool alternativaE = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    emailUser = widget.emailUser;
    Column returnAnswers(int index, List<Questao> listQuestoes,
        Map<int, String> respostasMarcadas) {
      return Column(
        children: [
          SizedBox(
            width: 800,
            height: 50,
            child: Text(
              // Print da pergunta
              'Pergunta: ' + ListQuestoesBD[index].pergunta,
              style: style,
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] ==
                'a', // verificar se a resposta está marcada
            onChanged: (bool? value) {
              setState(() {
                listaRespostasMarcada[index] = 'a';
                alternativaA = value!;
                alternativaB = false;
                alternativaC = false;
                alternativaD = false;
                alternativaE = false;
              });
            },
            title: SizedBox(
              child: Text('a) ' + ListQuestoesBD[index].respostaDaAlternativaA,
                  style: style), // Print da alternativa A
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] ==
                'b', // verificar se a resposta está marcada
            onChanged: (bool? value) {
              setState(() {
                listaRespostasMarcada[index] = 'b';
                alternativaB = value!;
                alternativaA = false;
                alternativaC = false;
                alternativaD = false;
                alternativaE = false;
              });
            },
            title: SizedBox(
              child: Text('b) ' + ListQuestoesBD[index].respostaDaAlternativaB,
                  style: style), // Print da alternativa B
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] ==
                'c', // verificar se a resposta está marcada
            onChanged: (bool? value) {
              setState(() {
                listaRespostasMarcada[index] = 'c';
                alternativaC = value!;
                alternativaA = false;
                alternativaB = false;
                alternativaD = false;
                alternativaE = false;
              });
            },
            title: SizedBox(
              child: Text('c) ' + ListQuestoesBD[index].respostaDaAlternativaC,
                  style: style), // Print da alternativa C
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] ==
                'd', // verificar se a resposta está marcada
            onChanged: (bool? value) {
              setState(() {
                listaRespostasMarcada[index] = 'd';
                alternativaD = value!;
                alternativaA = false;
                alternativaB = false;
                alternativaC = false;
                alternativaE = false;
              });
            },
            title: SizedBox(
              child: Text('d) ' + ListQuestoesBD[index].respostaDaAlternativaD,
                  style: style), // Print da alternativa D
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] ==
                'e', // verificar se a resposta está marcada
            onChanged: (bool? value) {
              setState(() {
                listaRespostasMarcada[index] = 'e';
                alternativaE = value!;
                alternativaA = false;
                alternativaB = false;
                alternativaC = false;
                alternativaD = false;
              });
            },
            title: SizedBox(
              child: Text('e) ' + ListQuestoesBD[index].respostaDaAlternativaE,
                  style: style), // Print da alternativa E
            ),
          ),
        ],
      );
    }

    return FutureBuilder<QuizClass>(
      future: receberQuizAptidaoBD(appState.idTreinamentoAtual),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Sinal de carregando se não receber os dados do bd
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Mensagem de erro se falhar no retorno dos dados
        } else {
          QuizClass? quiz = snapshot.data;
          ListQuestoesBD = quiz!.questoes;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Quiz'),
            titleTextStyle: style,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ListQuestoesBD.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                              title:
                                  Text('Questão ${index + 1}', style: style)),
                          returnAnswers(
                              index, ListQuestoesBD, listaRespostasMarcada),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    label: const Text('Finalizar Quiz'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      //envia as respostas do aluno do quiz para o bd
                      int status = await mandarQuizAptidao(
                          appState.logged.id,
                          ListQuestoesBD[0].idTreinamentoQuiz,
                          listaRespostasMarcada);
                      switch (status) {
                        case 0:
                          appState.erro(
                              'Aprovado! - Inscrição Realizada Com Sucesso!');
                          break;
                        case 1:
                          appState.erro('Reprovado - Inscrição Cancelada!');
                          break;
                        case 2:
                          appState.erro(
                              'Aprovado - Houve um erro durante a inscrição :(');
                          break;
                        default:
                          appState.erro(
                              'Erro no cadastro - entre em contato com um administrador!');
                          break;
                      }
                      appState.idTreinamentoAtual = '';
                      print("Enviou");
                    },
                  ),
                ],
              ),
              const SizedBox(width: 30),
            ],
          ),
        );
      },
    );
  }
}
