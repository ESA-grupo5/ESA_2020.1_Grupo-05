import 'package:Flahscard/database/controllers/subjects_ctr.dart';
import 'package:Flahscard/database/controllers/topics_ctr.dart';
import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/pages/topics_page.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:Flahscard/widgets/pop-ups/AddEditSubject.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Future<List<Subject>> _materias;

  @override
  void initState() {
    super.initState();
    _updateSubjectsList();
  }

  _updateSubjectsList() {
    SubjectsCtr subjectsCtr = SubjectsCtr();
    setState(() {
      _materias = subjectsCtr.getAllSubjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        toolbarHeight: 82,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "MATÉRIAS",
          style: GoogleFonts.quicksand().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
              height: 45,
              minWidth: 45,
              onPressed: showMateriaDialog,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: Color(0xff85ADBB).withOpacity(0.25),
              // elevation: 0,
              child: Center(
                child: Icon(
                  EvaIcons.plus,
                  color: Color(0xff85ADBB),
                ),
              ),
            ),
          )
        ],
      ),
      body: _buildMateriaList(),
    );
  }

  Widget _buildMateriaList() {
    return FutureBuilder(
      future: _materias,
      builder: (context, materias) {
        if (materias.hasData && materias.data.length > 0) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8),
            itemCount: materias.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildButtonSubject(materias.data[index]),
              );
            },
          );
        }

        if (materias.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator());

        return Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/subject_empty.png",
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 16),
                Text(
                  'Nenhuma matéria criada\nDica: Toque em "+" para adicionar.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonSubject(Subject materia) {
    TopicsCtr topicsCtr = TopicsCtr();
    return FlatButton(
      onPressed: () async {
        final result = await Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) {
              return TopicsPage(materia: materia);
            },
          ),
        );

        if (result == true) {
          _updateSubjectsList();
        }
      },
      padding: EdgeInsets.zero,
      color: colorPrimary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${materia.name}",
                    style: TextStyle(
                      color: colorTextPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  FutureBuilder(
                      future: topicsCtr.getAllTopics(materia.id),
                      builder: (context, assuntos) {
                        if (!assuntos.hasData) {
                          return Container();
                        }
                        return Text(
                          "${assuntos.data.length} assuntos",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Icon(
              EvaIcons.arrowIosForward,
              color: colorPrimary,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  showMateriaDialog({Subject editedMateria, int index}) async {
    bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddEditSubject();
      },
    );
    if (result == true) {
      _updateSubjectsList();
    }
  }
}
