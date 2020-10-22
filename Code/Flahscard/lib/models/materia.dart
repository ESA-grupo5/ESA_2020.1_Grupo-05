import 'package:Flahscard/models/cartao.dart';
import 'package:Flahscard/models/tema.dart';

class Materia {
  final int id;
  final String nome;
  final List<Tema> temas;

  Materia({this.id, this.nome, this.temas});
}

Materia teste = Materia(
  id: 1,
  nome: "Teste",
  temas: [
    Tema(
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
    ),
  ],
);
