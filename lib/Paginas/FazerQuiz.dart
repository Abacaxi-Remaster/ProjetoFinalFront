import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class FazerQuiz extends StatefulWidget {
  final int quizID;
  final String emailUser;

  const FazerQuiz({required this.quizID, required this.emailUser});

  @override
  FazerQuizState createState() => FazerQuizState();
}

class FazerQuizState extends State<FazerQuiz> {
  int quizID = 0;
  String emailUser = '';

  List<dynamic> dataListQuestoesBD = [];
  List<String> dataListRespostas = [];
  
  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    quizID = widget.quizID;
    emailUser = widget.emailUser;
        Column returnAnswers(index, listAnswers, listAnswersToAPI) {
      return Column(
        children: [
          SizedBox(
            width: 800,
            height: 50,
            child: Text(
                '${index + 1}-) ${dataListQuestoesBD[index]['questao']}',
                style: style),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listAnswers[index]['alternativa_a'],
            onChanged: (bool? value) {
              setState(() {
                listAnswersToAPI[index] = 'alternativa_a';

                listAnswers[index]['alternativa_a'] = value!;
                listAnswers[index]['alternativa_b'] = false;
                listAnswers[index]['alternativa_c'] = false;

              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_a'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listAnswers[index]['alternativa_b'],
            onChanged: (bool? value) {
              setState(() {
                listAnswersToAPI[index] = 'alternativa_b';
                listAnswers[index]['alternativa_b'] = value!;
                listAnswers[index]['alternativa_a'] = false;
                listAnswers[index]['alternativa_c'] = false;
              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_b'], style: style),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listAnswers[index]['alternativa_c'],
            onChanged: (bool? value) {
              setState(() {
                listAnswersToAPI[index] = 'alternativa_c';
                listAnswers[index]['alternativa_c'] = value!;
                listAnswers[index]['alternativa_b'] = false;
                listAnswers[index]['alternativa_a'] = false;
              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_c'], style: style),
            ),
          ),
        ],
      );
    }
    return Scaffold(
    );
  }
}