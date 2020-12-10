import 'package:Flahscard/database/controllers/paperboards_ctr.dart';
import 'package:Flahscard/models/paperboard.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';

class SeparetedPaperboardsPage extends StatefulWidget {
  final List<Paperboard> listCards;
  final Color topicColor;

  const SeparetedPaperboardsPage({Key key, this.listCards, this.topicColor})
      : super(key: key);

  @override
  _SeparetedPaperboardsPageState createState() =>
      _SeparetedPaperboardsPageState();
}

class _SeparetedPaperboardsPageState extends State<SeparetedPaperboardsPage>
    with TickerProviderStateMixin {
  int indexCardAtual = 0, countLearned = 0, countStudy = 0;
  List<Paperboard> listCards;
  List<Paperboard> listCardsToLearn = List<Paperboard>();
  bool isTemined = false;

  PaperboardsCtr paperboardsCtr = new PaperboardsCtr();

  @override
  void initState() {
    super.initState();
    listCards = widget.listCards;
    listCards.forEach((element) {
      if (element.alreadyLearned == 0) listCardsToLearn.add(element);
    });
    if (listCardsToLearn.length == 0) {
      isTemined = true;
      countLearned = 1;
    }
  }

  String getCongratulationText() {
    if (countStudy == 1 && countLearned != 0)
      return "Você acabou de aprender $countLearned termo(s)!\nContinue treinando para dominar o termo restante";
    if (countStudy == 1 && countLearned == 0)
      return "Continue treinando para dominar o termo restante";
    if (countStudy != 0 && countLearned == 0)
      return "Continue treinando para dominar os $countStudy termos restantes.";
    if (countStudy != 0 && countLearned != 0)
      return "Você acabou de aprender $countLearned term(o)!\nContinue treinando para dominar os $countStudy termos restantes.";
    return "Você aprendeu tudo!";
  }

  void _reset() {
    setState(() {
      listCards.forEach((element) {
        element.alreadyLearned = 0;
        paperboardsCtr.updatePaperboard(element);
      });
    });

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => SeparetedPaperboardsPage(
          listCards: listCards,
          topicColor: widget.topicColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
            "${indexCardAtual + 1}/${(listCardsToLearn.length == 0) ? "1" : listCardsToLearn.length} carta(s) para aprender",
            style: GoogleFonts.quicksand().copyWith(
              color: Colors.grey[800],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            icon: Icon(EvaIcons.close, color: Color(0xff85ADBB)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: (isTemined)
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 1.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Spacer(),
                          Image.asset(
                            'assets/flashly-happy.png',
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Bom trabalho!",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            getCongratulationText(),
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 64,
                            child: RawMaterialButton(
                              onPressed: () => _reset(),
                              fillColor: widget.topicColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "Estudar novamente",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              : TinderSwapCard(
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: listCardsToLearn.length,
                  stackNum: 2,
                  swipeEdge: 4,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 1.2,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 1.1,
                  cardController: controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
                    } else if (align.x > 0) {
                      //Card is RIGHT swiping
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    print(index);

                    setState(() {
                      if (indexCardAtual < listCardsToLearn.length - 1)
                        indexCardAtual += 1;
                      else
                        isTemined = true;
                    });
                    if (orientation == CardSwipeOrientation.RIGHT) {
                      setState(() {
                        listCardsToLearn[index].alreadyLearned = 1;
                        countLearned += 1;
                      });
                    } else if (orientation == CardSwipeOrientation.LEFT) {
                      setState(() {
                        listCardsToLearn[index].alreadyLearned = 0;
                        countStudy += 1;
                      });
                    }
                    paperboardsCtr.updatePaperboard(listCardsToLearn[index]);
                  },
                  cardBuilder: (context, index) => FlipCard(
                    front: Card(
                      child: Container(
                        child: Column(
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                listCards[index].front,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: colorTextPrimary,
                                ),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      child: Container(
                        child: Column(
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                listCards[index].back,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: colorTextPrimary,
                                ),
                                maxLines: 14,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
