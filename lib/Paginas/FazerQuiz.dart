import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  List<dynamic> ListQuestoesBD = []; //recebe os valores do bd
  List<String> listaRespostasMarcada =
      []; //receber o valor que a pessoa respondeu
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
    Column returnAnswers(index, listaRespostas, listaRespostasMarcada) {
      return Column(
        children: [
          SizedBox(
            width: 800,
            height: 50,
            child: Text(
              //Vai pegar do bd o numero da questao
              '${ListQuestoesBD[index]['enunciado']}',
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: alternativaA,
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
              child: Text(listaRespostas[index]['opcao_a'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: alternativaB,
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
              child: Text(listaRespostas[index]['opcao_b'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: alternativaC,
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
              child: Text(listaRespostas[index]['opcao_c'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: alternativaD,
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
              child: Text(listaRespostas[index]['opcao_d'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: alternativaE,
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
              child: Text(listaRespostas[index]['opcao_e'], style: style),
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
                            title: Text('${index + 1}', style: style),
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
