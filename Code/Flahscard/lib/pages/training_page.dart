import 'dart:async';
import 'dart:math';
import 'package:flip_card/flip_card.dart';

import 'package:Flahscard/models/paperboard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingPage extends StatefulWidget {
  final List<Paperboard> listCards;
  final Color color;

  const TrainingPage({Key key, this.listCards, this.color}) : super(key: key);
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  int time = 0;
  Timer timer;
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  List<bool> cardsFlips;
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
    initCardsFlips();
    questionsShuffle();
    getCards();
    startTimer();
  }

  void initCardsFlips() {
    for (int i = 0; i < listCards.length; i++) {
      this.cardsFlips.add(true);
    }
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
        leading: IconButton(
            icon: Icon(EvaIcons.close, color: Color(0xff85ADBB)),
            onPressed: _buildAlertDialog),
        backgroundColor: Colors.white,
        title: Text('$time segundos',
            style: GoogleFonts.quicksand().copyWith(
              color: Colors.grey[800],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => FlipCard(
                  onFlip: () {},
                  direction: FlipDirection.HORIZONTAL,
                  flipOnTouch: true,
                  front: Container(
                      height: 200,
                      margin: EdgeInsets.all(6.0),
                      padding: EdgeInsets.fromLTRB(6.0, 50.0, 6.0, 50.0),
                      color: Colors.deepOrange.withOpacity(0.3),
                      child: Center(child: Text(listCards[index].front))),
                  back: Container(
                    height: 200,
                    margin: EdgeInsets.all(6.0),
                    padding: EdgeInsets.fromLTRB(6.0, 30.0, 6.0, 30.0),
                    color: Colors.deepOrange,
                    child: Center(
                      child: Image.asset(
                        "assets/flashly-smile.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                itemCount: listCards.length,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _buildAlertDialog() {
    return showDialog(
          context: context,
          builder: (buildContext) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                'Tem certeza?',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              content: Text(
                "Deseja encerrar este treino? O seu progresso não será salvo.",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(buildContext),
                  child: Text(
                    'CANCELAR',
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: widget.color,
                    onPressed: () {
                      Navigator.pop(buildContext);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'SIM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
