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
  Map<int, String> listaRespostasMarcada = {}; //receber o valor que a pessoa respondeu
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
    Column returnAnswers(int index, List<Questao> listQuestoes, Map<int, String> respostasMarcadas) {
      //listaRespostasMarcada.add('');
      return Column(
        children: [
          SizedBox(
            width: 800,
            height: 50,
            child: Text(
              ListQuestoesBD[index].pergunta,
              //Vai pegar do bd o numero da questao
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] == 'a', // verificar se a resposta está marcada
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
              child: Text(ListQuestoesBD[index].respostaDaAlternativaA, style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] == 'b',
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
              child: Text(ListQuestoesBD[index].respostaDaAlternativaB, style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] == 'c',
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
              child: Text(ListQuestoesBD[index].respostaDaAlternativaC, style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] == 'd',
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
              child: Text(ListQuestoesBD[index].respostaDaAlternativaD, style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: respostasMarcadas[index] == 'e',
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
              child: Text(ListQuestoesBD[index].respostaDaAlternativaE, style: style),
            ),
          ),
        ],
      );
    }

 return FutureBuilder<QuizClass>(
      future: receberQuizAptidaoBD(appState.idTreinamentoAtual),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Display an error message if data retrieval fails
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
                            title: Text ('${index + 1}', style: style)
                          ),
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
                      //funcao para corrigir teste
                      //corrigirTeste(index, ListQuestoesBD ,listaRespostasMarcada);
                      appState.idTreinamentoAtual = '';
                      Navigator.of(context).pop();
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
