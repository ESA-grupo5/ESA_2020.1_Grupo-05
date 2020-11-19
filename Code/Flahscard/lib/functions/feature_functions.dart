import 'package:Flahscard/functions/verification_functions.dart';
import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/subject.dart';

void adicionarMateria(Subject materia) {
  if (verificarAdicionarMateria(materia))
    materias.add(materia);
  else
    print("Erro!!!!!!");
}
