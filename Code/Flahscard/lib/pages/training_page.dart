import 'dart:async';
import 'dart:math';
import 'package:Flahscard/pages/result_training_page.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

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

  List<bool> cardFlips = List<bool>();
  List<Paperboard> listCards = List<Paperboard>();
  List<String> data = List<String>();
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  int previousIndex = -1;
  bool flip = false;

  var index = new Random();
  @override
  void initState() {
    super.initState();
    listCards = widget.listCards;
    for (var i = 0; i < listCards.length * 2; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < listCards.length; i++) {
      data.add(listCards[i].front);
    }
    for (var i = 0; i < listCards.length; i++) {
      data.add(listCards[i].back);
    }
    data.shuffle();
    startTimer();
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
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => FlipCard(
                  key: cardStateKeys[index],
                  onFlip: () {
                    if (!flip) {
                      flip = true;
                      previousIndex = index;
                    } else {
                      flip = false;
                      if (previousIndex != index) {
                        Paperboard carta1 = Paperboard(
                            front: data[previousIndex], back: data[index]);
                        Paperboard carta2 = Paperboard(
                            front: data[index], back: data[previousIndex]);
                        if (listCards
                                .where((element) =>
                                    ((element.front == carta1.front &&
                                            element.back == carta1.back) ||
                                        (element.front == carta2.front &&
                                            element.back == carta2.back)))
                                .toList()
                                .length ==
                            0) {
                          cardStateKeys[previousIndex]
                              .currentState
                              .toggleCard();
                          previousIndex = index;
                        } else {
                          cardFlips[previousIndex] = false;
                          cardFlips[index] = false;
                          print(cardFlips);

                          if (cardFlips.every((t) => t == false)) {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => ResultTrainingPage(
                                    seconds: time, topicColor: widget.color)));
                          }
                        }
                      }
                    }
                  },
                  direction: FlipDirection.HORIZONTAL,
                  flipOnTouch: cardFlips[index],
                  back: Container(
                    height: 200,
                    color: Colors.deepOrange.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              data[index],
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  front: Container(
                    height: 200,
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
                itemCount: data.length,
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
