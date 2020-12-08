import 'dart:math';

import 'package:Flahscard/models/paperboard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestsPage extends StatefulWidget {
  final List<Paperboard> listCards;

  const TestsPage({Key key, this.listCards}) : super(key: key);
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  List<Paperboard> listCards;
  int indexCard, indexCorrectAlternative;
  Paperboard card;
  var index = new Random();
  @override
  void initState() {
    super.initState();
    listCards = widget.listCards;
    indexCard = 0;
    indexCorrectAlternative = 0;
    card = new Paperboard();
    questionsShuffle();
    getCards();
  }

  void buttonAlternativeCorrectRandom() {
    switch (listCards.length) {
      case 2:
        setState(() {
          indexCorrectAlternative = index.nextInt(2);
        });

        break;
      case 3:
        setState(() {
          indexCorrectAlternative = index.nextInt(3);
        });
        break;

      default:
        setState(() {
          indexCorrectAlternative = index.nextInt(4);
        });
    }
  }

  void questionsShuffle() {
    setState(() {
      listCards.shuffle();
    });
  }

  void getCards() {
    setState(() {
      card = listCards[indexCard];
    });
  }

  void getNextQuestion() {
    setState(() {
      indexCard += 1;
    });

    getCards();
    buttonAlternativeCorrectRandom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${indexCard + 1}/${listCards.length}",
            style: GoogleFonts.quicksand().copyWith(
              color: Colors.grey[800],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
              icon: Icon(EvaIcons.close, color: Color(0xff85ADBB)),
              onPressed: () {})
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(card.back),
        ],
      ),
    );
  }
}
