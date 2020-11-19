import '../models/paperboard.dart';

enum Status { Aprovado, Reprovado }

Status realizarTeste(String resposta, Paperboard cartao) {
  if (cartao.back == resposta) {
    return Status.Aprovado;
  } else {
    return Status.Reprovado;
  }
}
