import '../models/cartao.dart';

final List<Cartao> listaDeCartoes = [];

void criarCartao(int id, int idTema, String frente, String verso) {
  Cartao cartao = Cartao(id: id, idTema: idTema, frente: frente, verso: verso);
  listaDeCartoes.add(cartao);
}

