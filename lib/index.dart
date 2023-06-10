import 'package:http/http.dart' as http;
import 'package:projeto_final_front/Paginas/Quiz.dart';
import 'dart:convert';

import 'package:projeto_final_front/all.dart';

validaNull(value) {
  if (value == null || value.isEmpty) {
    return '*Campo Obrigatório!';
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
  String cargaHoraria;
  int codigo;
  String minCandidatos;
  String maxCandidatos;
  DateTime dataInicialInscricao;
  DateTime dataFinalInscricao;
  DateTime dataInicialTreinamento;
  DateTime dataFinalTreinamento;

  Treinamento({
    required this.nomeComercial,
    required this.descricao,
    required this.cargaHoraria,
    required this.codigo,
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
        'codigo=$codigo, '
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
      "carga_horaria": int.parse(cargaHoraria),
      "comeco_insc": dataInicialInscricao.toIso8601String(),
      "fim_insc": dataFinalInscricao.toIso8601String(),
      "comeco_treinamento": dataInicialTreinamento.toIso8601String(),
      "fim_treinamento": dataFinalTreinamento.toIso8601String(),
      "qntd_min_insc": int.parse(minCandidatos),
      "qntd_max_insc": int.parse(maxCandidatos),
    };
  }

  factory Treinamento.fromJson(Map<String, dynamic> json) {
    print(json);
    return Treinamento(
      nomeComercial: json['descricao'],
      descricao: json['descricao'],
      cargaHoraria: json['descricao'],
      codigo: json['descricao'],
      minCandidatos: json['descricao'],
      maxCandidatos: json['descricao'],
      dataInicialInscricao: json['descricao'],
      dataFinalInscricao: json['descricao'],
      dataInicialTreinamento: json['descricao'],
      dataFinalTreinamento: json['descricao'],
    );
  }
}

class QuizClass {
  List<Questao> questoes = [];

  void addQuestao(questaox) {
    questoes.add(questaox);
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
    Uri.parse("http://localhost:8000/treinamentos"),
    headers: {'Content-Type': 'application/json'},
    body: jsonTotal,
  );

  if (response.statusCode == 200) {
    print('Treinamento registrado com sucesso');
  }
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

  String url = 'http://localhost:8000/vagas//$idEmpresa';

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

Future<List<String>> getInscritos(String idVaga) async {
  List<String> inscritos = [];

  String url = 'http://localhost:8000/vagas//$idVaga';

  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> decodedData = jsonDecode(response.body);
    inscritos = []; //decodar aqui!
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

//Treinamento

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
