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
  final treinamentosController = TextEditingController();
  List<Pergunta> perguntas = [];
  String pergunta = '';
  List<String> respostas = ['', '', '', '', ''];
  List<bool> alternativasCorretas = [false, false, false, false, false];

  String perguntaAtual = '';
  List<String> respostasAtuais = [];
  bool alternativaCorretaAtual = false;

  void criarPergunta() {
    if (perguntaAtual.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, preencha a pergunta antes de adicionar.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    int countAlternativasCorretas = alternativasCorretas.where((correta) => correta).length;
    if (countAlternativasCorretas != 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, selecione uma única alternativa correta.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
          respostasAtuais = List.from(respostas);

          List<Alternativa> alternativas = [];
          for (int i = 0; i < respostasAtuais.length; i++) {
            if (alternativasCorretas[i]) {
              alternativas.add(Alternativa(texto: respostasAtuais[i], correta: true));
            }
          }
          perguntas.add(
            Pergunta(
              enunciado: perguntaAtual,
              opcoesResposta: [
                Respostas(
                  quizTreinamento: widget.quizID,
                  questao: 'Questão ${perguntas.length + 1}',
                  pergunta: perguntaAtual,
                  alternativas: alternativas,
                ),
              ],
            ),
          );
      limparCampos();
    });
  }

  void limparCampos() {
    setState(() {
      pergunta = '';
      respostas = ['', '', '', '', ''];
      alternativasCorretas = [false, false, false, false, false];
      perguntaAtual = '';
      respostasAtuais = [];
      alternativaCorretaAtual = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                perguntaAtual = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Pergunta',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              setState(() {
                respostas[0] = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Resposta A',
            ),
          ),
          CheckboxListTile(
            value: alternativasCorretas[0],
            onChanged: (value) {
              setState(() {
                alternativasCorretas[0] = value!;
              });
            },
            title: Text('Selecionar'),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              setState(() {
                respostas[1] = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Resposta B',
            ),
          ),
          CheckboxListTile(
            value: alternativasCorretas[1],
            onChanged: (value) {
              setState(() {
                alternativasCorretas[1] = value!;
              });
            },
            title: Text('Selecionar'),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              setState(() {
                respostas[2] = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Resposta C',
            ),
          ),
          CheckboxListTile(
            value: alternativasCorretas[2],
            onChanged: (value) {
              setState(() {
                alternativasCorretas[2] = value!;
              });
            },
            title: Text('Selecionar'),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              setState(() {
                respostas[3] = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Resposta D',
            ),
          ),
          CheckboxListTile(
            value: alternativasCorretas[3],
            onChanged: (value) {
              setState(() {
                alternativasCorretas[3] = value!;
              });
            },
            title: Text('Selecionar'),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              setState(() {
                respostas[4] = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Resposta E',
            ),
          ),
          CheckboxListTile(
            value: alternativasCorretas[4],
            onChanged: (value) {
              setState(() {
                alternativasCorretas[4] = value!;
              });
            },
            title: Text('Selecionar'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              criarPergunta();
            },
            child: Text('Adicionar Pergunta'),
          ),
          SizedBox(height: 20),
          Text(
            'Perguntas Salvas:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: perguntas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Pergunta ${index + 1}: ${perguntas[index].enunciado}'),
                  subtitle: Text('Alternativa Correta: ${perguntas[index].opcoesResposta[0].alternativas[0].texto}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Respostas {
  String pergunta = '';
  String questao = '';
  List<Alternativa> alternativas = [];

  int quizTreinamento;

  Respostas({
    required this.quizTreinamento,
    required this.questao,
    required this.pergunta,
    required this.alternativas,
  });
}

class Alternativa {
  String texto;
  bool correta;

  Alternativa({required this.texto, required this.correta});
}

class Pergunta {
  String enunciado;
  List<Respostas> opcoesResposta;

  Pergunta({
    required this.enunciado,
    required this.opcoesResposta,
  });
}

class QuizData {
  int quizID;
  String titulo;
  List<Pergunta> perguntas;
  String perguntaAtual;

  QuizData({
    required this.quizID,
    required this.titulo,
    required this.perguntas,
    required this.perguntaAtual,
  });
}