import 'package:Flahscard/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:Flahscard/models/paperboard.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';

class AddEditCard extends StatefulWidget {
  final Paperboard card;
  final Topic topic;

  const AddEditCard({Key key, this.card, this.topic}) : super(key: key);
  @override
  _AddEditCardState createState() => _AddEditCardState();
}

class _AddEditCardState extends State<AddEditCard> {
  final _formKeyFront = GlobalKey<FormState>();
  final _formKeyBack = GlobalKey<FormState>();

  TextEditingController _textControllerFront = TextEditingController();
  TextEditingController _textControllerBack = TextEditingController();

  String _front = "";
  String _back = "";
  int _idTopic = 0;
  Color _colorTopic;

  @override
  void initState() {
    super.initState();
    if (widget.card != null) {
      _front = widget.card.front;
      _back = widget.card.back;
      _idTopic = widget.card.topicId;
    } else {
      _idTopic = widget.topic.id;
      _colorTopic = widget.topic.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: KeyboardAwareDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                (widget.topic != null) ? 'Nova carta' : 'Editar carta',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Form(
                key: _formKeyFront,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _textControllerFront,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _front = input,
                  onChanged: (input) => setState(() => _front = input),
                  validator: (input) {
                    if (input.trim().isEmpty) return 'Insira um termo';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    labelStyle: TextStyle(
                      fontSize: 22.0,
                      color: Colors.grey[800],
                    ),
                    // border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _colorTopic,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4, bottom: 0),
              child: Text(
                'TERMO',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Form(
                key: _formKeyBack,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _textControllerBack,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _front = input,
                  onChanged: (input) => setState(() => _front = input),
                  validator: (input) {
                    if (input.trim().isEmpty) return 'Insira uma descrição';
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    labelStyle: TextStyle(
                      fontSize: 22.0,
                      color: Colors.grey[800],
                    ),
                    // border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: _colorTopic,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 4, bottom: 0),
              child: Text(
                'DESCRIÇÃO',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCELAR',
                    style: TextStyle(
                      color: _colorTopic,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RawMaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: (_textControllerBack.text != '' &&
                          _textControllerFront.text != '')
                      ? _colorTopic
                      : _colorTopic.withOpacity(0.5),
                  elevation: (_textControllerBack.text != '' &&
                          _textControllerFront.text != '')
                      ? 2
                      : 0,
                  onPressed: () {
                    if (_formKeyFront.currentState.validate() &&
                        _formKeyBack.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.card != null ? 'SALVAR' : 'CRIAR CARTA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
