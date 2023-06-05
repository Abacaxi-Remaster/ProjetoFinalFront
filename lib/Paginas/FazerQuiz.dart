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
    
    return Scaffold(
    );
  }
}