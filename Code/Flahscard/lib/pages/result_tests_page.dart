import 'package:Flahscard/lists.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultTestsPage extends StatefulWidget {
  final int countCorrectResponses, listCardsLength;
  final Color topicColor;

  const ResultTestsPage(
      {Key key,
      this.countCorrectResponses,
      this.listCardsLength,
      this.topicColor})
      : super(key: key);

  @override
  _ResultTestsPageState createState() => _ResultTestsPageState();
}

class _ResultTestsPageState extends State<ResultTestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("Resultados do teste",
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
            CircularPercentIndicator(
              radius: 160.0,
              lineWidth: 7.0,
              animation: true,
              percent:
                  widget.countCorrectResponses / widget.listCardsLength.round(),
              center: new Text(
                ((widget.countCorrectResponses / widget.listCardsLength) * 100)
                        .roundToDouble()
                        .toString() +
                    " %",
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34.0,
                  color: Colors.grey[800],
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: widget.topicColor,
            ),
            SizedBox(height: 8),
            Text(
              (widget.countCorrectResponses == widget.listCardsLength)
                  ? "Dominou!"
                  : "Continue estudando!",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Você acertou ${widget.countCorrectResponses} de ${widget.listCardsLength} perguntas",
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
