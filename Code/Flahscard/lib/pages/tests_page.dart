import 'dart:math';

import 'package:Flahscard/models/paperboard.dart';
import 'package:Flahscard/pages/result_tests_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestsPage extends StatefulWidget {
  final List<Paperboard> listCards;
  final Color color;

  const TestsPage({Key key, this.listCards, this.color}) : super(key: key);
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  List<Paperboard> listCards, listCardsAlternatives = [];
  int indexCard, indexCorrectAlternative, countCorretResponses;
  Paperboard card;
  var index = new Random();

  @override
  void initState() {
    super.initState();
    listCards = widget.listCards;
    indexCard = 0;
    indexCorrectAlternative = 0;
    countCorretResponses = 0;
    card = listCards[indexCard];
    questionsShuffle();
    getCard();
    buttonAlternativeCorrectRandom();
    alternativesShuffle();
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
        break;
    }
  }

  void questionsShuffle() {
    setState(() {
      listCards.shuffle();
    });
  }

  void getCard() {
    setState(() {
      card = listCards[indexCard];
    });
  }

  void alternativesShuffle() {
    listCardsAlternatives.clear();
    listCards.forEach((carta) {
      if (!listCardsAlternatives.contains(carta) &&
          carta != card &&
          listCardsAlternatives.length < 5) {
        setState(() {
          listCardsAlternatives.add(carta);
        });
      }
    });
    listCardsAlternatives.forEach((element) {
      print(element.front);
    });
  }

  void getNextQuestion(Paperboard carta) {
    setState(() => countCorretResponses += (carta == card) ? 1 : 0);
    if ((indexCard + 1) == listCards.length) {
      Navigator.pop(context);
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => ResultTestsPage(
            countCorrectResponses: countCorretResponses,
            listCardsLength: listCards.length,
            topicColor: widget.color,
          ),
        ),
      );
    } else {
      setState(() {
        indexCard += 1;
      });

      getCard();
      buttonAlternativeCorrectRandom();
      alternativesShuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _buildAlertDialog,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text("${indexCard + 1}/${listCards.length}",
              style: GoogleFonts.quicksand().copyWith(
                color: Colors.grey[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            IconButton(
              icon: Icon(EvaIcons.close, color: Color(0xff85ADBB)),
              onPressed: _buildAlertDialog,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                card.back,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
              ),
            ),
            Spacer(),
            ListView.builder(
              reverse: true,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, indexButton) {
                if (indexButton > listCards.length - 1) return Container();
                if (indexButton == indexCorrectAlternative)
                  return _buidAlternativeButton(card);
                return _buidAlternativeButton(
                    listCardsAlternatives[indexButton]);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buidAlternativeButton(Paperboard carta) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: widget.color, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () => getNextQuestion(carta),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                carta.front,
                style: TextStyle(color: Colors.grey[800]),
                textAlign: TextAlign.start,
              ),
            ),
          ],
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
                "Deseja encerrar este teste? O seu progresso não será salvo.",
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
