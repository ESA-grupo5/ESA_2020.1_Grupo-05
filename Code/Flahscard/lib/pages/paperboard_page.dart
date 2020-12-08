import 'package:Flahscard/database/controllers/paperboards_ctr.dart';
import 'package:Flahscard/database/controllers/topics_ctr.dart';
import 'package:Flahscard/models/paperboard.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:Flahscard/pages/tests_page.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:Flahscard/widgets/buttons/MoreOptionsButton.dart';
import 'package:Flahscard/widgets/pop-ups/AddEditCard.dart';
import 'package:Flahscard/widgets/pop-ups/AddEditTopic.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

class PaperboardPage extends StatefulWidget {
  final Topic assunto;

  const PaperboardPage({Key key, this.assunto}) : super(key: key);

  @override
  _PaperboardPageState createState() => _PaperboardPageState();
}

class _PaperboardPageState extends State<PaperboardPage> {
  Future<List<Paperboard>> _cartas;
  Topic _assunto;

  TopicsCtr topicsCtr = TopicsCtr();
  PaperboardsCtr paperboardsCtr = PaperboardsCtr();

  @override
  void initState() {
    super.initState();
    _assunto = widget.assunto;
    _updatePapeboardsList();
  }

  _updateTopic() async {
    final assuntoTemp = await topicsCtr.getTopic(_assunto.id);
    setState(() {
      _assunto = assuntoTemp;
    });
  }

  _updatePapeboardsList() {
    setState(() {
      _cartas = paperboardsCtr.getAllPaperboards(widget.assunto.id);
    });
  }

  _deleteTopic(BuildContext popUpContext) {
    topicsCtr.deleteTopic(widget.assunto.id);
    Navigator.pop(popUpContext);
    Navigator.pop(context, true);
  }

  _deletePaperboard(int cardId, BuildContext popUpContext) {
    PaperboardsCtr paperboardsCtr = PaperboardsCtr();
    paperboardsCtr.deletePaperboard(cardId);
    _updatePapeboardsList();
    Navigator.pop(popUpContext);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "${_assunto.name}",
            style: GoogleFonts.quicksand().copyWith(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: Icon(
              EvaIcons.arrowIosBack,
              color: Color(0xff85ADBB),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MoreOptionsButton(
                textToEdit: "Editar assunto",
                textToDelete: "Excluir assunto",
                textToAlertDelete:
                    'O assunto "${_assunto.name}" será definivamente excluído.',
                showEditDialog: showAssuntoDialog,
                color: _assunto.color,
                delete: _deleteTopic,
              ),
            ),
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: _cartas,
            builder: (context, cartas) {
              if (!cartas.hasData) return Container();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    (cartas.data.length == 0)
                        ? SizedBox(height: 8)
                        : Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 300,
                            child: Swiper(
                              itemCount: cartas.data.length,
                              itemHeight: 250,
                              viewportFraction: 0.5,
                              outer: true,
                              loop: false,
                              itemWidth:
                                  MediaQuery.of(context).size.width - 2 * 95,
                              layout: SwiperLayout.DEFAULT,
                              pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                  color: Colors.grey,
                                  activeColor: _assunto.color,
                                  size: 7,
                                ),
                              ),
                              itemBuilder: (context, index) {
                                return FlipCard(
                                  direction: FlipDirection.HORIZONTAL,
                                  front: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Text(
                                              cartas.data[index].front,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: colorTextPrimary,
                                              ),
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Icon(
                                                  EvaIcons.expand,
                                                  color: _assunto.color,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  back: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Text(
                                              cartas.data[index].back,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: colorTextPrimary,
                                              ),
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Icon(
                                                  EvaIcons.expand,
                                                  color: _assunto.color,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16),
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 16,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.7225,
                      ),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return _buildOptionButton(
                              "Treino",
                              EvaIcons.pieChartOutline,
                              (cartas.data.length > 1)
                                  ? () {}
                                  : () {
                                      Scaffold.of(context).showSnackBar(
                                          _buidSnackBar(cartas.data.length));
                                    },
                              (cartas.data.length > 1),
                            );
                            break;
                          case 1:
                            return _buildOptionButton(
                              "Cartas",
                              EvaIcons.copyOutline,
                              (cartas.data.length > 1)
                                  ? () {}
                                  : () {
                                      Scaffold.of(context).showSnackBar(
                                          _buidSnackBar(cartas.data.length));
                                    },
                              (cartas.data.length > 1),
                            );
                            break;
                          case 2:
                            return _buildOptionButton(
                              "Nova carta",
                              EvaIcons.edit2,
                              showPaperboardDialog,
                              true,
                            );
                            break;
                          default:
                            return _buildOptionButton(
                              "Teste",
                              EvaIcons.fileTextOutline,
                              (cartas.data.length > 1)
                                  ? () {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) => TestsPage(
                                                  listCards: cartas.data)));
                                    }
                                  : () {
                                      Scaffold.of(context).showSnackBar(
                                          _buidSnackBar(cartas.data.length));
                                    },
                              (cartas.data.length > 1),
                            );
                            break;
                        }
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 32,
                        ),
                        Text(
                          "Cartas",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorTextPrimary,
                          ),
                        ),
                        SizedBox(width: 8),
                        (cartas.data.length != 0)
                            ? Text(
                                "| ${cartas.data.length} termos",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    (cartas.data.length == 0)
                        ? Container(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/images/no_data.png",
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.width / 3,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Nenhuma carta criada\nToque em “Nova carta” para adicionar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cartas.data.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: RawMaterialButton(
                                onPressed: () =>
                                    _buildBottomSheet(cartas.data[index]),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                fillColor: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        cartas.data[index].front,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: colorTextPrimary,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 16),
                                      child: Divider(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        cartas.data[index].back,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: colorTextPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
      String text, IconData icon, Function function, bool isEmpty) {
    return RawMaterialButton(
      onPressed: function,
      elevation: (isEmpty) ? 2 : 0,
      fillColor: (isEmpty) ? Colors.white : Color(0xff85ADBB).withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        child: Column(
          children: [
            Spacer(),
            Icon(
              icon,
              color: colorPrimary,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                color: _assunto.color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: _assunto.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar _buidSnackBar(int length) {
    return SnackBar(
      content: Text(
        'Crie pelo menos ${-length + 2} carta(s)!',
        style: GoogleFonts.quicksand().copyWith(fontWeight: FontWeight.bold),
      ),
      duration: Duration(milliseconds: 1500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
    );
  }

  showPaperboardDialog() async {
    bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddEditCard(
          topic: _assunto,
          color: _assunto.color,
        );
      },
    );
    if (result == true) {
      _updatePapeboardsList();
    }
  }

  showAssuntoDialog() async {
    bool result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AddEditTopic(assunto: _assunto);
      },
    );
    if (result == true) {
      _updateTopic();
    }
  }

  _buildBottomSheet(Paperboard carta) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return AnimatedPadding(
            duration: Duration(milliseconds: 150),
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    bool result = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AddEditCard(
                          topic: _assunto,
                          card: carta,
                          color: _assunto.color,
                        );
                      },
                    );
                    if (result == true) {
                      _updatePapeboardsList();
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.edit2,
                        color: _assunto.color,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Editar carta",
                        style: TextStyle(
                          color: colorTextPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
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
                            "Esta carta será definitivamente excluída.",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'CANCELAR',
                                style: TextStyle(
                                  color: _assunto.color,
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
                                color: _assunto.color,
                                onPressed: () =>
                                    _deletePaperboard(carta.id, context),
                                child: Text(
                                  'EXCLUIR',
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
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.trash2,
                        color: _assunto.color,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Excluir carta",
                        style: TextStyle(
                          color: colorTextPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        });
  }
}
