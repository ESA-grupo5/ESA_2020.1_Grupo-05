import '../models/paperboard.dart';

enum Status { Aprovado, Reprovado }

Status realizarTreino(String resposta, Paperboard cartao) {
  if (cartao.back == resposta) {
    print("Você acertou");
    return Status.Aprovado;
  } else {
    print("A resposta certa é " + cartao.back);
    return Status.Reprovado;
  }
}
