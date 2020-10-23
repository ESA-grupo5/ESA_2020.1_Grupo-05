import '../models/cartao.dart';

enum Status { Aprovado, Reprovado }

Status realizarTeste(String resposta, Cartao cartao) {
  if (cartao.verso == resposta) {
    return Status.Aprovado;
  } else {
    return Status.Reprovado;
  }
}