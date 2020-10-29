import 'package:Flahscard/functions/verification_functions.dart';
import 'package:Flahscard/lists.dart';
import '../models/tema.dart';

void adicionarTema(int id, int idMateria, String nome) {
  Tema tema = Tema(id: id, idMateria: idMateria, nome: nome);
  if (verificarAdicionarTema(tema)) {
    temas.add(tema);
  } else {
    print("ERROOOOOO!");
  }
}
