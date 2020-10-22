import 'package:Flahscard/models/cartao.dart';

class Tema {
  final int id;
  final int idMateria;
  final String nome;
  final List<Cartao> cartas;

  Tema({this.id, this.idMateria, this.nome, this.cartas});
}

Tema teste = Tema(
  id: 1,
  idMateria: 1,
  nome: "Teste",
  cartas: [
    Cartao(
      id: 1,
      idTema: 1,
      frente: "Não faço ideia",
      verso: "Não sei",
    ),
  ],
);
