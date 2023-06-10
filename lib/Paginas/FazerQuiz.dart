import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class FazerQuiz extends StatefulWidget {
  final String emailUser;
  final String quizID;

  const FazerQuiz({required this.emailUser, required this.quizID});

  @override
  FazerQuizState createState() => FazerQuizState();
}

class FazerQuizState extends State<FazerQuiz> {
  String quizID = '0';
  String emailUser = '';
  List<dynamic> dataListQuestoesBD = [];
  List<String> dataListRespostas = [];
  @override
  void initState() {
    super.initState();
    populateDataListQuestoesBD();
  }

  void populateDataListQuestoesBD() {
    List<dynamic> dataListQuestoesBD = [
      {
        'questao': 'Qual é a capital do Brasil?',
        'resposta_a': 'São Paulo',
        'resposta_b': 'Rio de Janeiro',
        'resposta_c': 'Brasília',
        'resposta_d': 'Salvador',
        'resposta_e': 'Belo Horizonte',
      },
      {
        'questao': 'Qual é o maior rio do mundo?',
        'resposta_a': 'Nilo',
        'resposta_b': 'Amazonas',
        'resposta_c': 'Mississippi',
        'resposta_d': 'Yangtzé',
        'resposta_e': 'Danúbio',
      },
      // Adicione mais questões aqui
    ];
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    emailUser = widget.emailUser;
    Column returnAnswers(index, listaRespostas, listaRespostasToAPI) {
      return Column(
        children: [
          SizedBox(
            width: 800,
            height: 50,
            child: Text(
              '${dataListQuestoesBD[index]['questao']}',
              //child: Text('Questão 1', style: style)
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listaRespostas[index]['a'],
            onChanged: (bool? value) {
              setState(() {
                listaRespostasToAPI[index] = 'a';
                listaRespostas[index]['alternativa_a'] = value!;
                listaRespostas[index]['alternativa_b'] = false;
                listaRespostas[index]['alternativa_c'] = false;
                listaRespostas[index]['alternativa_d'] = false;
                listaRespostas[index]['alternativa_e'] = false;
              });
            },
            title: SizedBox(
              child: Text(listaRespostas[index]['resposta_a'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listaRespostas[index]['b'],
            onChanged: (bool? value) {
              setState(() {
                listaRespostasToAPI[index] = 'b';
                listaRespostas[index]['alternativa_b'] = value!;
                listaRespostas[index]['alternativa_a'] = false;
                listaRespostas[index]['alternativa_c'] = false;
                listaRespostas[index]['alternativa_d'] = false;
                listaRespostas[index]['alternativa_e'] = false;
              });
            },
            title: SizedBox(
              child: Text(listaRespostas[index]['resposta_b'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listaRespostas[index]['c'],
            onChanged: (bool? value) {
              setState(() {
                listaRespostasToAPI[index] = 'c';
                listaRespostas[index]['alternativa_c'] = value!;
                listaRespostas[index]['alternativa_a'] = false;
                listaRespostas[index]['alternativa_b'] = false;
                listaRespostas[index]['alternativa_d'] = false;
                listaRespostas[index]['alternativa_e'] = false;
              });
            },
            title: SizedBox(
              child: Text(listaRespostas[index]['resposta_c'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listaRespostas[index]['d'],
            onChanged: (bool? value) {
              setState(() {
                listaRespostasToAPI[index] = 'd';
                listaRespostas[index]['alternativa_d'] = value!;
                listaRespostas[index]['alternativa_a'] = false;
                listaRespostas[index]['alternativa_b'] = false;
                listaRespostas[index]['alternativa_c'] = false;
                listaRespostas[index]['alternativa_e'] = false;
              });
            },
            title: SizedBox(
              child: Text(listaRespostas[index]['resposta_d'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listaRespostas[index]['e'],
            onChanged: (bool? value) {
              setState(() {
                listaRespostasToAPI[index] = 'e';
                listaRespostas[index]['alternativa_e'] = value!;
                listaRespostas[index]['alternativa_a'] = false;
                listaRespostas[index]['alternativa_b'] = false;
                listaRespostas[index]['alternativa_c'] = false;
                listaRespostas[index]['alternativa_d'] = false;
              });
            },
            title: SizedBox(
              child: Text(listaRespostas[index]['resposta_e'], style: style),
            ),
          ),
        ],
      );
    }

    final buttonCancel = ButtonTheme(
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
            Navigator.of(context).pop();
          },
          child: Text(
            "Voltar",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );

    final buttonSendAnswers = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      child: ButtonTheme(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            print("Enviou");
          },
          child: Text(
            "Enviar",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text('Quiz'),
          titleTextStyle: style,
          automaticallyImplyLeading: false),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dataListQuestoesBD.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      ListTile(
                        title: Text('${index + 1}', style: style),
                      ),
                      returnAnswers(
                          index, dataListQuestoesBD, dataListRespostas),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                    ]);
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                label: const Text('Finalizar Quiz'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Enviar QUIZ?'),
                          content:
                              const Text('As alternativas foram assinaladas?'),
                          actions: [buttonSendAnswers, buttonCancel],
                        );
                      });
                },
              ),
              const SizedBox(width: 30),
            ]),
          ]),
    );
  }
}
