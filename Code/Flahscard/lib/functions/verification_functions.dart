import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/materia.dart';

bool verificarAdicionarMateria(Materia materia) {
  if (!materias.contains(materia))
    return false;
  else if (materia.nome.length < 2) return false;
  return true;
}
