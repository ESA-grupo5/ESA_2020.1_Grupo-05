import 'package:Flahscard/models/subject.dart';
import 'package:flutter/material.dart';

class AddEditSubject extends StatefulWidget {
  final Subject materia;

  // Construtor para receber uma tarefa quando precisar edita-la
  AddEditSubject({this.materia});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<AddEditSubject> {
  final _titleController = TextEditingController();

  Subject _materiaAtual = Subject();

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.materia == null ? 'Nova materia' : 'Editar materia'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Materia'),
              autofocus: true)
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCELAR'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('CRIAR MATERIA'),
          onPressed: () {
            _materiaAtual.name = _titleController.value.text;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
