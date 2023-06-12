import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projeto_final_front/Paginas/Quiz.dart';
import 'dart:convert';

import 'package:projeto_final_front/all.dart';

validaNull(value) {
  if (value == null || value.isEmpty) {
    return '*Campo Obrigatório!';
  }
  return null;
}

validaNullClean(value) {
  if (value == null || value.isEmpty) {
    return '';
  }
  return null;
}

//Cadastro/Login:
class RegisterUser {
  int tipo;
  String nome;
  String email;
  String senha;
  String ultimo;

  RegisterUser(this.tipo, this.nome, this.email, this.senha, this.ultimo);

  Map<String, dynamic> toJson() {
    switch (tipo) {
      case 0:
        return {
          'usuario': "alunos",
          'nome': nome,
          'email': email,
          'senha': senha,
          'curso': ultimo
        };
      case 1:
        return {
          'usuario': "mentores",
          'nome': nome,
          'email': email,
          'senha': senha,
          'CPF': ultimo
        };
      case 2:
        return {
          'usuario': "empresas",
          'nome': nome,
          'email': email,
          'senha': senha,
          'CNPJ': ultimo
        };
      default:
        return {'tipo': '', 'nome': '', 'email': '', 'senha': '', 'ultimo': ''};
    }
  }
}

Future<int> cadastro(tipo, nome, email, senha, ultimo) async {
  RegisterUser newUser = RegisterUser(tipo, nome, email, senha, ultimo);

  String jsonUser = jsonEncode(newUser.toJson());

  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/cadastro"),
    headers: {'Content-Type': 'application/json'},
    body: jsonUser,
  );

  if (response.statusCode == 200) {
    print('Cadastro feito com sucesso');
  } else {
    if (response.statusCode == 400) {
      print('erro no cadastro');
    }
  }
  return response.statusCode;
}

class LoggedUser {
  int tipo;
  String email;
  String senha;
  String nome;
  String id;

  LoggedUser(this.tipo, this.email, this.senha, this.nome, this.id);

  Map<String, dynamic> toJson() {
    switch (tipo) {
      case 0:
        return {
          'usuario': "alunos",
          'email': email,
          'senha': senha,
        };
      case 1:
        return {
          'usuario': "mentores",
          'email': email,
          'senha': senha,
        };
      case 2:
        return {
          'usuario': "empresas",
          'email': email,
          'senha': senha,
        };
      case 3:
        return {
          'usuario': "adm",
          'email': email,
          'senha': senha,
        };
      default:
        return {'default': ''};
    }
  }

  static LoggedUser fromJson(Map<String, dynamic> json, int tipo) {
    return LoggedUser(
      tipo,
      json['email'],
      json['senha'],
      json['nome'],
      json['id'],
    );
  }
}

Future<LoggedUser> login(tipo, email, senha) async {
  LoggedUser user = LoggedUser(tipo, email, senha, '', '');
  String jsonUser = jsonEncode(user.toJson());
  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonUser,
  );
  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    print("logou!");
    print(jsonBody);
    LoggedUser logged = LoggedUser.fromJson(jsonBody, tipo);
    return logged;
  } else {
    if (response.statusCode == 204) {
      print("204");
    } else {
      print("outro");
    }
    return LoggedUser(204, 'email', 'senha', 'nome', 'id');
  }
}

//Treinamento/Quiz:
class Treinamento {
  String nomeComercial;
  String descricao;
  int cargaHoraria;
  String id;
  int minCandidatos;
  int maxCandidatos;
  DateTime dataInicialInscricao;
  DateTime dataFinalInscricao;
  DateTime dataInicialTreinamento;
  DateTime dataFinalTreinamento;

  Treinamento({
    required this.nomeComercial,
    required this.descricao,
    required this.cargaHoraria,
    required this.id,
    required this.minCandidatos,
    required this.maxCandidatos,
    required this.dataInicialInscricao,
    required this.dataFinalInscricao,
    required this.dataInicialTreinamento,
    required this.dataFinalTreinamento,
  });

  @override
  String toString() {
    return 'Treinamento: '
        'nomeComercial=$nomeComercial, '
        'descricao=$descricao, '
        'cargaHoraria=$cargaHoraria, '
        'id=$id, '
        'minCandidatos=$minCandidatos, '
        'maxCandidatos=$maxCandidatos, '
        'dataInicialInscricao=$dataInicialInscricao, '
        'dataFinalInscricao=$dataFinalInscricao, '
        'dataInicialTreinamento=$dataInicialTreinamento, '
        'dataFinalTreinamento=$dataFinalTreinamento';
  }

  Map<String, dynamic> toJson() {
    return {
      "nome_comercial": nomeComercial,
      "descricao": descricao,
      "carga_horaria": cargaHoraria,
      "comeco_insc": dataInicialInscricao.toIso8601String(),
      "fim_insc": dataFinalInscricao.toIso8601String(),
      "comeco_treinamento": dataInicialTreinamento.toIso8601String(),
      "fim_treinamento": dataFinalTreinamento.toIso8601String(),
      "qntd_min_insc": minCandidatos,
      "qntd_max_insc": maxCandidatos,
    };
  }

  factory Treinamento.fromJson(Map<String, dynamic> json) {
    print(json);
    return Treinamento(
      nomeComercial: json['nome_comercial'],
      descricao: json['descricao'],
      cargaHoraria: json['carga_horaria'],
      id: json['id'],
      minCandidatos: json['qntd_min_insc'],
      maxCandidatos: json['qntd_max_insc'],
      dataInicialInscricao:
          DateTime.parse(json['comeco_insc']), //2023-06-10T19:17:48.239772
      dataFinalInscricao: DateTime.parse(json['fim_insc']),
      dataInicialTreinamento: DateTime.parse(json['comeco_treinamento']),
      dataFinalTreinamento: DateTime.parse(json['fim_treinamento']),
    );
  }
}

class QuizClass {
  String Nome = '';
  List<Questao> questoes = [];

  QuizClass() {
    Nome = '';
    questoes = [];
  }

  void addNome(String value) {
    Nome = value;
  }

  void addQuestao(questaox) {
    questoes.add(questaox);
  }

  factory QuizClass.fromJson(List<Map<String, dynamic>> json) {
    final quiz = QuizClass();
    json.forEach((questaoJson) {
      final questao = Questao.fromJson(questaoJson);
      quiz.addQuestao(questao);
    });
    return quiz;
  }

  List<Map<String, dynamic>> toJson() {
    return questoes.map((questaox) => questaox.toJson()).toList();
  }
}

void criaTreinamento(Treinamento novoTreinamento, List<QuizClass> quiz) async {
  String jsonTreinamento = jsonEncode(novoTreinamento.toJson());
  List<List<Map<String, dynamic>>> arrjsonQuestoes = [];

  for (int i = 0; i < quiz.length; i++) {
    arrjsonQuestoes.add(quiz[i].toJson());
  }

  Map<String, dynamic> requestData = {
    'treinamentos': novoTreinamento.toJson(),
    'quiz': arrjsonQuestoes,
  };

  String jsonTotal = jsonEncode(requestData);

  print(jsonTotal);

  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/treinamentos/cadastro"),
    headers: {'Content-Type': 'application/json'},
    body: jsonTotal,
  );

  if (response.statusCode == 200) {
    print('Treinamento registrado com sucesso');
  }
}

Future<List<Treinamento>> listaTreinamentos(idAluno) async {
  List<Treinamento> treinamentos = [];

  String url = 'http://localhost:8000/treinamentos/$idAluno';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    treinamentos =
        decodedData.map((data) => Treinamento.fromJson(data)).toList();
  } else {
    print(response.statusCode);
  }

  return treinamentos;
}

Future<List<Treinamento>> listaTreinamentosAluno(String idAluno) async {
  List<Treinamento> treinamentos = [];

  String url = 'http://localhost:8000/treinamento/aluno/${idAluno}';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    treinamentos =
        decodedData.map((data) => Treinamento.fromJson(data)).toList();
  } else {
    print(response.statusCode);
  }

  return treinamentos;
}

//Vagas/Inscritos:
class Vaga {
  String tituloVaga;
  String descricao;
  String id;
  String idEmpresaContratando;
  String requisitos;
  int salario;

  Vaga(
      {required this.tituloVaga,
      required this.descricao,
      required this.id,
      required this.idEmpresaContratando,
      required this.requisitos,
      required this.salario});

  factory Vaga.fromJson(Map<String, dynamic> json) {
    print(json);
    return Vaga(
      tituloVaga: json['titulo_vaga'],
      descricao: json['descricao'],
      id: json['id'],
      idEmpresaContratando: json['id_empresa'],
      requisitos: json['requisitos'],
      salario: json['salario'],
    );
  }

  @override
  String toString() {
    return 'Vaga: '
        'tituloVaga=$tituloVaga, '
        'descricao=$descricao, '
        'id=$id, '
        'id_empresa=$idEmpresaContratando, '
        'requisitos=$requisitos, '
        'salario=$salario';
  }

  Map<String, dynamic> toJson() {
    return {
      "titulo_vaga": tituloVaga,
      "descricao": descricao,
      "id_empresa": idEmpresaContratando,
      "requisitos": requisitos,
      "salario": salario
    };
  }
}

void criaVaga(
    tituloVaga, descricao, id, idEmpresa, requisitos, int salario) async {
  Vaga novaVaga = Vaga(
      tituloVaga: tituloVaga,
      descricao: descricao,
      id: 'id',
      idEmpresaContratando: idEmpresa,
      requisitos: requisitos,
      salario: salario);
  String jsonVaga = jsonEncode(novaVaga.toJson());
  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/vagas/cadastro"),
    headers: {'Content-Type': 'application/json'},
    body: jsonVaga,
  );
  print(jsonVaga);
  if (response.statusCode == 200) {
    print('Vaga registrada com sucesso');
  } else {
    print(response.statusCode);
  }
}

Future<List<Vaga>> listaVagas() async {
  List<Vaga> vagas = [];

  http.Response response = await http.get(
    Uri.parse('http://localhost:8000/vagas'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    vagas = decodedData.map((data) => Vaga.fromJson(data)).toList();
  } else {
    print(response.statusCode);
  }

  return vagas;
}

Future<List<Vaga>> listaVagasAluno(String idAluno) async {
  List<Vaga> vagas = [];

  String url = 'http://localhost:8000/vagas/inscrito/$idAluno';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    vagas = decodedData.map((data) => Vaga.fromJson(data)).toList();
  } else {
    print(response.statusCode);
  }

  return vagas;
}

Future<List<Vaga>> listaVagasEmpresa(String idEmpresa) async {
  List<Vaga> vagas = [];

  String url = 'http://localhost:8000/vagas/empresa/$idEmpresa';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    vagas = decodedData.map((data) => Vaga.fromJson(data)).toList();
  } else {
    print(response.statusCode);
  }

  return vagas;
}

Future<List<String>> getInscritos(String idVaga) async {
  List<String> inscritos = [];

  String url = 'http://localhost:8000/vagas/todosInscritos/$idVaga';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    inscritos =
        List<String>.from(decodedData.map((dynamic item) => item['nome']));
  } else {
    print(response.statusCode);
  }

  return inscritos;
}

class InscritoVaga {
  String idVaga;
  String idAluno;

  InscritoVaga({required this.idVaga, required this.idAluno});
  Map<String, dynamic> toJson() {
    return {
      "id_aluno": idAluno,
      "id_vaga": idVaga,
    };
  }
}

void criaInscricaoVaga(idVaga, idAluno) async {
  InscritoVaga inscricao = InscritoVaga(idVaga: idVaga, idAluno: idAluno);
  String jsonInscricao = jsonEncode(inscricao.toJson());

  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/vagas/inscricao"),
    headers: {'Content-Type': 'application/json'},
    body: jsonInscricao,
  );
  if (response.statusCode == 200) {
    print('Inscrição realizada com sucesso');
  } else {
    print(response.statusCode);
  }
}

void criaInscricaoTreinamento(idVaga, idAluno) async {
  InscritoVaga inscricao = InscritoVaga(idVaga: idVaga, idAluno: idAluno);
  String jsonInscricao = jsonEncode(inscricao.toJson());

  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/vagas/inscricao"),
    headers: {'Content-Type': 'application/json'},
    body: jsonInscricao,
  );
  if (response.statusCode == 200) {
    print('Inscrição realizada com sucesso');
  } else {
    print(response.statusCode);
  }
}

//Treinamento

Future<QuizClass> receberQuizAptidaoBD(idTreinamento) async {
  QuizClass Quiz = QuizClass();
  print('chamou: idTreinamento: $idTreinamento');
  http.Response response = await http.get(
    Uri.parse('http://localhost:8000/quiz/aptidao/$idTreinamento'),
    headers: {'Content-Type': 'application/json'},
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    Quiz = QuizClass.fromJson(decodedData.cast<Map<String, dynamic>>());
  } else {
    print(response.statusCode);
  }

  return Quiz;
}

void mandarQuiz(id_aluno ,id_quiz, mapaRespostas) async{
  List<String> Resposta = [];
  mapaRespostas.forEach((key, value) {
    print('Questão $key: $value');
    Resposta.add(value.toUpperCase());
    print(Resposta);
    print(id_quiz);
  });

  Map<String, dynamic> jsonMap = {
      'id_aluno': id_aluno,
      'id_quiz': id_quiz,
      'resposta': Resposta,
  };

  String jsonString = json.encode(jsonMap);
  print(jsonString);

  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/historico_alunos/cadastro"),
    headers: {'Content-Type': 'application/json'},
    body: jsonString,
  );
  if (response.statusCode == 200) {
    print('Inscrição realizada com sucesso');
  } else {
    print(response.statusCode);
  }
}

Future<QuizClass> receberNotaQuiz(idTreinamento) async {
  QuizClass Quiz = QuizClass();
  print('chamou: idTreinamento: $idTreinamento');
  http.Response response = await http.get(
    Uri.parse('http://localhost:8000/quiz/aptidao/$idTreinamento'),
    headers: {'Content-Type': 'application/json'},
  );

  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    Quiz = QuizClass.fromJson(decodedData.cast<Map<String, dynamic>>());
  } else {
    print(response.statusCode);
  }

  return Quiz;
}
