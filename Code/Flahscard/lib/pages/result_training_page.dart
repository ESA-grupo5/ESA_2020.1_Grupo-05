import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class ResultTrainingPage extends StatefulWidget {
  final int seconds;
  final Color topicColor;

  const ResultTrainingPage({Key key, this.seconds, this.topicColor})
      : super(key: key);

  @override
  _ResultTrainingPageState createState() => _ResultTrainingPageState();
}

class _ResultTrainingPageState extends State<ResultTrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("Resultados do treino",
            style: GoogleFonts.quicksand().copyWith(
              color: Colors.grey[800],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            icon: Icon(EvaIcons.close, color: Color(0xff85ADBB)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            SizedBox(height: 4),
            Text(
              "Você terminou em ${widget.seconds} segundos",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 64,
                child: RawMaterialButton(
                  onPressed: () => Navigator.pop(context),
                  fillColor: widget.topicColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Fechar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
