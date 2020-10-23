import '../models/cartao.dart';

enum Status { Aprovado, Reprovado }

Status realizarTreino(String resposta, Cartao cartao) {
  if (cartao.verso == resposta) {
    print("Você acertou");
    return Status.Aprovado;
  } else {
    print("A resposta certa é " + cartao.verso);
    return Status.Reprovado;
  }
}
