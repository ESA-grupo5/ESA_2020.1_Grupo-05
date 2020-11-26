import 'package:Flahscard/constants.dart';
import 'package:Flahscard/database/controllers/subjects_ctr.dart';
import 'package:Flahscard/functions/verification_functions.dart';
import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';

class AddEditSubject extends StatefulWidget {
  final Subject materia;

  AddEditSubject({this.materia});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<AddEditSubject> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  String _name = "";
  int _idMateria = 0;

  @override
  void initState() {
    if (widget.materia != null) {
      _textController.text = widget.materia.name;
      _name = widget.materia.name;
      _idMateria = widget.materia.id;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textController.clear();
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      SubjectsCtr subjectsCtr = new SubjectsCtr();

      Subject subject = Subject(
        name: _name,
        userId: userIdConstant,
      );

      if (widget.materia == null) {
        subjectsCtr.insertSubject(subject);
        _textController.clear();
      } else {
        subject.id = widget.materia.id;
        subjectsCtr.updateSubject(subject);
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
                (widget.materia != null) ? 'Editar matéria' : 'Nova matéria',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
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
                  onSaved: (input) => _name = input,
                  onChanged: (input) => setState(() => _name = input),
                  validator: (input) {
                    if (verificanameIsEmpty(input))
                      return 'Insira um nome para a matéria';
                    if (!verificanameMateriaExists(input))
                      return 'O name da matéria já existe';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[800],
                    ),
                    // border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: colorPrimary,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "Título da Matéria",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
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
                      color: colorPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RawMaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: _textController.text != ''
                      ? colorPrimary
                      : colorPrimary.withOpacity(0.5),
                  elevation: _textController.text != '' ? 2 : 0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _submit();
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(
                    widget.materia != null ? 'SALVAR' : 'CRIAR MATÉRIA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
