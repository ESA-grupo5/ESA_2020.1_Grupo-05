import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:string_validator/string_validator.dart';

bool verificarAdicionarMateria(Subject materia) {
  if (!materias.contains(materia))
    return false;
  else if (materia.name.length < 2) return false;
  return true;
}

bool verificarAdicionarTema(Topic tema) {
  if (materias
          .where((element) => element.id == tema.subjectId)
          .toList()
          .length !=
      0) {
    if (temas
            .where((element) => element.subjectId == tema.subjectId)
            .toList()
            .where((element) => element.name == tema.name)
            .toList()
            .length ==
        0) {
      return true;
    }
    if (!isAlpha(tema.name) || tema.name.isEmpty) {
      return false;
    }
    return false;
  }
  return false;
}

bool verificanameMateriaExists(String name) {
  return materias.where((element) => element.name == name).toList().length == 0;
}

bool verificanameTopicExists(String name, int subjectId) {
  return temas
          .where((element) => element.subjectId == subjectId)
          .toList()
          .where((element) => element.name == name)
          .toList()
          .length ==
      0;
}

bool verificaLengthnameMateria(String name) {
  return name.length > 2;
}

bool verificanameIsEmpty(String name) {
  return name.trim().isEmpty;
}

bool verificaIsAlpha(String name) {
  return isAlpha(name);
}
