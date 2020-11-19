import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/widgets/AddEditSubject.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  List<Subject> _materias = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text("Materias"), actions: <Widget>[
        MaterialButton(
          child: Icon(EvaIcons.plus),
          onPressed: () {
            _ShowMateriaDialog();
          },
        )
      ]),
      body: _buildMateriaList(),
    );
  }

  Widget _buildMateriaList() {
    if (_materias.isEmpty) {
      return Center(
        child: _loading ? CircularProgressIndicator() : Text("Sem tarefas!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: null,
        itemCount: _materias.length,
      );
    }
  }

  Future _ShowMateriaDialog({Subject editedMateria, int index}) async {
    final materia = await showDialog<Subject>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddEditSubject();
        });

    if (materia != null) {
      setState(() {
        if (index == null) {
          _materias.add(materia);
        } else {
          _materias[index] = materia;
        }
      });
    }
  }
}
