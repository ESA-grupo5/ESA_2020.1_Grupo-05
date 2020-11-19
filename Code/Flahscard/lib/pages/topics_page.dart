import 'package:Flahscard/lists.dart';
import 'package:Flahscard/widgets/AddEditTopic.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Engenharia de Software",
          style: GoogleFonts.quicksand().copyWith(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            EvaIcons.arrowBack,
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
        child: GridView.builder(
            itemCount: 3 + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 8, crossAxisCount: 2),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (context) => AddEditTopic(),
                        )
                      },
                      icon: Stack(
                        children: [
                          Icon(
                            EvaIcons.folder,
                            color: Color(0xff85ADBB).withOpacity(0.25),
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 0),
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
                      color: topicColors[index - 1],
                    ),
                    iconSize: 155,
                  ),
                  Text(
                    "Nome do assunto",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
