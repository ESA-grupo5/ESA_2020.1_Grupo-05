import 'package:Flahscard/functions/theme_functions.dart';
import 'package:Flahscard/functions/verification_functions.dart';
import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:Flahscard/variables.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';

class AddEditTopic extends StatefulWidget {
  final Topic topic;

  const AddEditTopic({Key key, this.topic}) : super(key: key);
  @override
  _AddEditTopicState createState() => _AddEditTopicState();
}

class _AddEditTopicState extends State<AddEditTopic> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController = TextEditingController();
  String _name = "";
  int _idMateria = 0;
  Color _colorTopic;

  @override
  void initState() {
    super.initState();
    if (widget.topic != null) {
      _textController.text = widget.topic.name;
      _name = widget.topic.name;
      _idMateria = widget.topic.subjectId;
    } else {
      _colorTopic = topicColors[0];
    }
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Topic topic = Topic(
        subjectId: _idMateria,
        name: _name,
      );

      if (widget.topic == null) {
        adicionarTema(topic);
        _textController.clear();
        idTema += 1;
      } else {
        temas[temas.indexOf(widget.topic)] = topic;
      }
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
                (widget.topic != null) ? 'Editar assunto' : 'Novo assunto',
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
                key: _formKey,
                child: TextFormField(
                  controller: _textController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (input) => _name = input,
                  onChanged: (input) => setState(() => _name = input),
                  validator: (input) {
                    if (verificanameIsEmpty(input))
                      return 'Insira um nome para o assunto';
                    if (!verificanameTopicExists(input, _idMateria))
                      return 'O name do assunto já existe';
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
                    hintText: "Título do assunto",
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
              padding: const EdgeInsets.only(left: 16.0, top: 4, bottom: 16),
              child: Text(
                'Cor',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 45,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: topicColors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: new InkWell(
                        onTap: () {
                          setState(() {
                            _colorTopic = topicColors[index];
                          });
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Stack(
                            children: [
                              Icon(
                                EvaIcons.folder,
                                size: 45,
                                color: topicColors[index],
                              ),
                              Center(
                                child: AnimatedContainer(
                                  margin: EdgeInsets.only(top: 4),
                                  duration: Duration(milliseconds: 150),
                                  height:
                                      topicColors[index] == _colorTopic ? 8 : 0,
                                  width:
                                      topicColors[index] == _colorTopic ? 8 : 0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
                  fillColor: _textController.text != ''
                      ? _colorTopic
                      : _colorTopic.withOpacity(0.5),
                  elevation: _textController.text != '' ? 2 : 0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _submit();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.topic != null ? 'SALVAR' : 'CRIAR ASSUNTO',
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
