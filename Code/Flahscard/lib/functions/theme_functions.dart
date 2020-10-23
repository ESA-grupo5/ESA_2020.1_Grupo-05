import '../models/tema.dart';

final List<Tema> listaDeTemas = [];

void adcionarTema(int id, int idMateria, String nome) {
  Tema tema = Tema(id: id, idMateria: idMateria, nome: nome);
  listaDeTemas.add(tema);
}
