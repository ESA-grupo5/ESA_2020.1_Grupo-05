import 'package:Flahscard/database/controllers/subjects_ctr.dart';
import 'package:Flahscard/database/controllers/topics_ctr.dart';
import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:Flahscard/pages/paperboard_page.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:Flahscard/widgets/buttons/MoreOptionsButton.dart';
import 'package:Flahscard/widgets/pop-ups/AddEditSubject.dart';
import 'package:Flahscard/widgets/pop-ups/AddEditTopic.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicsPage extends StatefulWidget {
  final Subject materia;

  const TopicsPage({Key key, this.materia}) : super(key: key);
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  Future<List<Topic>> _assuntos;
  Subject _materia;

  SubjectsCtr subjectsCtr = SubjectsCtr();
  TopicsCtr topicsCtr = TopicsCtr();

  @override
  void initState() {
    super.initState();
    _materia = widget.materia;
    _updateTopicsList();
  }

  _updateSubject() async {
    final materiaTemp = await subjectsCtr.getSubject(_materia.id);
    setState(() {
      _materia = materiaTemp;
    });
  }

  _updateTopicsList() {
    setState(() {
      _assuntos = topicsCtr.getAllTopics(widget.materia.id);
    });
  }

  _delete(BuildContext popUpContext) {
    subjectsCtr.deleteSubject(widget.materia.id);
    Navigator.pop(popUpContext);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "${_materia.name}",
            style: GoogleFonts.quicksand().copyWith(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: Icon(
              EvaIcons.arrowIosBack,
              color: Color(0xff85ADBB),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MoreOptionsButton(
                textToEdit: "Editar matéria",
                textToDelete: "Excluir matéria",
                textToAlertDelete:
                    'A matéria "${_materia.name}" será definivamente excluída.',
                color: colorPrimary,
                delete: _delete,
                showEditDialog: showMateriaDialog,
              ),
            )
          ],
        ),
        body: Container(
          child: FutureBuilder(
              future: _assuntos,
              builder: (context, assuntos) {
                if (!assuntos.hasData) return Container();
                return GridView.builder(
                    itemCount: assuntos.data.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 8, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: showAssuntoDialog,
                              icon: SvgPicture.asset(
                                'assets/images/folder_add.svg',
                              ),
                              iconSize: MediaQuery.of(context).size.width / 2.5,
                            ),
                            Text(
                              "Novo assunto",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff85ADBB),
                              ),
                            )
                          ],
                        );
                      }
                      return _buildTopicButton(assuntos.data[index - 1]);
                    });
              }),
        ),
      ),
    );
  }

  Widget _buildTopicButton(Topic assunto) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            final result = await Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => PaperboardPage(assunto: assunto),
              ),
            );

            if (result == true) _updateTopicsList();
          },
          icon: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/folder_back.svg',
                color: Colors.grey[700],
              ),
              SvgPicture.asset(
                'assets/images/folder.svg',
                color: assunto.color,
              ),
            ],
          ),
          iconSize: MediaQuery.of(context).size.width / 2.5,
        ),
        Text(
          assunto.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        )
      ],
    );
  }

  showAssuntoDialog({Subject editedMateria, int index}) async {
    bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddEditTopic(
          materia: widget.materia,
        );
      },
    );
    if (result == true) {
      _updateTopicsList();
    }
  }

  showMateriaDialog({Subject editedMateria, int index}) async {
    bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddEditSubject(materia: _materia);
      },
    );
    if (result == true) {
      _updateSubject();
    }
  }
}
