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

class _SeparetedPaperboardsPageState extends State<SeparetedPaperboardsPage> {
  int indexCardAtual = 0;
  List<Paperboard> listCards;

  @override
  void initState() {
    super.initState();
    listCards = widget.listCards;
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("${indexCardAtual + 1}/${listCards.length}",
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
      body: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: TinderSwapCard(
          orientation: AmassOrientation.BOTTOM,
          totalNum: listCards.length,
          stackNum: 2,
          swipeEdge: 4,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 1.2,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 1.1,
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              //Card is LEFT swiping
            } else if (align.x > 0) {
              //Card is RIGHT swiping
            }
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card!
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
    );
  }
}
