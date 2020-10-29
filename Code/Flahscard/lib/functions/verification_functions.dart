import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/materia.dart';
import 'package:Flahscard/models/tema.dart';
import 'package:string_validator/string_validator.dart';

bool verificarAdicionarMateria(Materia materia) {
  if (!materias.contains(materia))
    return false;
  else if (materia.nome.length < 2) return false;
  return true;
}

bool verificarAdicionarTema(Tema tema) {
  if (materias
          .where((element) => element.id == tema.idMateria)
          .toList()
          .length !=
      0) {
    if (temas
            .where((element) => element.idMateria == tema.idMateria)
            .toList()
            .where((element) => element.nome == tema.nome)
            .toList()
            .length ==
        0) {
      return true;
    }
    if (!isAlpha(tema.nome) || tema.nome.isEmpty) {
      return false;
    }
    return false;
  }
  return false;
}
