import 'package:Flahscard/database/controllers/topics_ctr.dart';
import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:Flahscard/widgets/pop-ups/AddEditTopic.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicsPage extends StatefulWidget {
  final Subject materia;

  const TopicsPage({Key key, this.materia}) : super(key: key);
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  Future<List<Topic>> _assuntos;
  @override
  void initState() {
    super.initState();
    _updateTopicsList();
  }

  _updateTopicsList() {
    TopicsCtr topicsCtr = TopicsCtr();
    setState(() {
      _assuntos = topicsCtr.getAllTopics(widget.materia.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "${widget.materia.name}",
          style: GoogleFonts.quicksand().copyWith(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.arrowIosBack,
            color: Color(0xff85ADBB),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.moreVertical,
              color: Colors.grey[800],
            ),
            onPressed: () {},
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
                            onPressed: _ShowAssuntoDialog,
                            icon: Stack(
                              children: [
                                Icon(
                                  EvaIcons.folder,
                                  color: Color(0xff85ADBB).withOpacity(0.25),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, bottom: 0),
                                    child: Icon(
                                      EvaIcons.plus,
                                      color: Color(0xff85ADBB),
                                      size: 40,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            iconSize: 155,
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
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            EvaIcons.folder,
                            color: assuntos.data[index - 1].color,
                          ),
                          iconSize: 155,
                        ),
                        Text(
                          assuntos.data[index - 1].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        )
                      ],
                    );
                  });
            }),
      ),
    );
  }

  _ShowAssuntoDialog({Subject editedMateria, int index}) async {
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
}
