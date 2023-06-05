import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'FazerQuiz.dart';


class CursosPage extends StatefulWidget {
  final String userType;
  final String emailUser;

  const CursosPage({required this.userType, required this.emailUser});

  @override
  CursosPageState createState() => CursosPageState();
}

class CursosPageState extends State<CursosPage> {
  final testesController =  TextEditingController();
  String _userType = '';
  String _emailUser = '';
  final buttonDoQuizVisibility = true;
  List<dynamic> dataListCursosBD = [];

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    var appState = context.watch<MyAppState>();
    Visibility buttonDoQuiz(index) {
      return Visibility(
        visible: buttonDoQuizVisibility,
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
                Navigator.of(context).pop();
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FazerQuiz(quizID: int.parse(dataListCursosBD[index]['Código do Curso']), emailUser: _emailUser)));
              },
              child: Text(
                "Fazer Quiz",
                textAlign: TextAlign.center,
                style: style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      
    );

    return Scaffold(
      
    );
  }
}