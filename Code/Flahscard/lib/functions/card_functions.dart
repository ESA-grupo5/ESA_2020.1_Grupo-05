import '../models/paperboard.dart';

final List<Paperboard> listaDeCartoes = [];

void criarCard(int id, int idTema, String frente, String verso) {
  Paperboard card = Paperboard(topicId: idTema, front: frente, back: verso);
  listaDeCartoes.add(card);
}
