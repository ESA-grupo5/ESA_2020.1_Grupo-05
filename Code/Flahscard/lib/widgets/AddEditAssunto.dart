import 'package:Flahscard/functions/theme_functions.dart';
import 'package:Flahscard/functions/verification_functions.dart';
import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/cartao.dart';
import 'package:Flahscard/models/tema.dart';
import 'package:Flahscard/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';

class AddEditAssunto extends StatefulWidget {
  final Tema assunto;

  const AddEditAssunto({Key key, this.assunto}) : super(key: key);
  @override
  _AddEditAssuntoState createState() => _AddEditAssuntoState();
}

class _AddEditAssuntoState extends State<AddEditAssunto> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  String _nomeAssunto = "";
  int _idTema = 0;
  int _idMateria = 0;
  List<Cartao> _cartas = [];

  @override
  void initState() {
    super.initState();
    if (widget.assunto != null) {
      _textController.text = widget.assunto.nome;
      _nomeAssunto = widget.assunto.nome;
      _idTema = widget.assunto.id;
      _idMateria = widget.assunto.idMateria;
      _cartas = widget.assunto.cartas;
    } else {
      _idTema = idTema;
    }
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Tema assunto = Tema(
        id: _idTema,
        idMateria: _idMateria,
        nome: _nomeAssunto,
        cartas: _cartas,
      );

      if (widget.assunto == null) {
        adicionarTema(assunto);
        _textController.clear();
        idTema += 1;
      } else {
        temas[temas.indexOf(widget.assunto)] = assunto;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: KeyboardAwareDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                (widget.assunto != null) ? 'Editar assunto' : 'Novo assunto',
                style: TextStyle(
                  color: Colors.grey[850],
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _textController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _nomeAssunto = input,
                  onChanged: (input) => setState(() => _nomeAssunto = input),
                  validator: (input) {
                    if (verificaNomeIsEmpty(input))
                      return 'Insira um nome para o assunto';
                    if (!verificaIsAlpha(input)) return 'Insira somente letras';
                    if (!verificaNomeAssuntoExists(input, _idMateria))
                      return 'O nome do assunto já existe';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.grey[850],
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                      color: Colors.grey,
                    ),
                    // border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                    ),
                    hintText: "Título do Assunto",
                    hintStyle: TextStyle(
                      color: Color(0xFF86829D),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCELAR',
                    style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _submit();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.assunto != null ? 'SALVAR' : 'CRIAR ASSUNTO',
                    style: TextStyle(
                      color: _textController.text != ''
                          ? Colors.grey[850]
                          : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
