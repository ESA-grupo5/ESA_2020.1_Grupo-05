import 'package:Flahscard/functions/verification_functions.dart';
import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/materia.dart';

void adicionarMateria(Materia materia) {
  if (verificarAdicionarMateria(materia))
    materias.add(materia);
  else
    print("Erro!!!!!!");
}
