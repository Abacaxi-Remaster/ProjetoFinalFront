import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projeto_final_front/all.dart';

validaNull(value) {
  if (value == null || value.isEmpty) {
    return '*Campo Obrigatório!';
  }
  return null;
}

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
          'usuario': "ADM",
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
      "carga_horaria": cargaHoraria,
      "comeco_insc": dataInicialInscricao,
      "fim_insc": dataFinalInscricao,
      "comeco_treinamento": dataInicialTreinamento,
      "fim_treinamento": dataFinalTreinamento,
      "qntd_min_insc": minCandidatos,
      "qntd_max_insc": maxCandidatos,
    };
  }
}

void criaTreinamento(
    nomeComercial,
    descricao,
    cargaHoraria,
    codigo,
    minCandidatos,
    maxCandidatos,
    dataInicialInscricao,
    dataFinalInscricao,
    dataInicialTreinamento,
    dataFinalTreinamento) async {
  Treinamento novoTreinamento = Treinamento(
      nomeComercial: nomeComercial,
      descricao: descricao,
      cargaHoraria: cargaHoraria,
      codigo: codigo,
      minCandidatos: minCandidatos,
      maxCandidatos: maxCandidatos,
      dataInicialInscricao: dataInicialInscricao,
      dataFinalInscricao: dataFinalInscricao,
      dataInicialTreinamento: dataInicialTreinamento,
      dataFinalTreinamento: dataFinalTreinamento);
  String jsonTreinamento = jsonEncode(novoTreinamento.toJson());
  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/treinamentos"),
    headers: {'Content-Type': 'application/json'},
    body: jsonTreinamento,
  );
  if (response.statusCode == 200) {
    print('Treinamento registrado com sucesso');
  }
}

class Vaga {
  String tituloVaga;
  String descricao;
  int id;
  String empresaContratando;
  String requisitos;
  String salario;

  Vaga(
      {required this.tituloVaga,
      required this.descricao,
      required this.id,
      required this.empresaContratando,
      required this.requisitos,
      required this.salario});

  @override
  String toString() {
    return 'Vaga: '
        'tituloVaga=$tituloVaga, '
        'descricao=$descricao, '
        'id=$id, '
        'empresaContratando=$empresaContratando, '
        'requisitos=$requisitos, '
        'salario=$salario';
  }

  Map<String, dynamic> toJson() {
    return {
      "tituloVaga": tituloVaga,
      "descricao": descricao,
      "empresaContratando": empresaContratando,
      "requisitos": requisitos,
      "salario": salario
    };
  }
}

void criaVaga(
    tituloVaga, descricao, id, empresaContratando, requisitos, salario) async {
  Vaga novaVaga = Vaga(
      tituloVaga: tituloVaga,
      descricao: descricao,
      id: id,
      empresaContratando: empresaContratando,
      requisitos: requisitos,
      salario: salario);
  String jsonVaga = jsonEncode(novaVaga.toJson());
  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/vagas"),
    headers: {'Content-Type': 'application/json'},
    body: jsonVaga,
  );
  if (response.statusCode == 200) {
    print('Vaga registrada com sucesso');
  }
}

class Inscrito {
  int idVaga;
  int idAluno;

  Inscrito({required this.idVaga, required this.idAluno});
  Map<String, dynamic> toJson() {
    return {
      "id_aluno": idAluno,
      "id_vagas": idVaga,
    };
  }
}

void criaInscricao(idVaga, idAluno) async {
  Inscrito inscricao = Inscrito(idVaga: idVaga, idAluno: idAluno);
  String jsonInscricao = jsonEncode(inscricao.toJson());
  http.Response response = await http.post(
    Uri.parse("http://localhost:8000/"),
    headers: {'Content-Type': 'application/json'},
    body: jsonInscricao,
  );
  if (response.statusCode == 200) {
    print('Inscrição realizada com sucesso');
  }
}
