import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreOptionsButton extends StatefulWidget {
  final Function showEditDialog, delete;
  final String textToDelete, textToEdit, textToAlertDelete;
  final Color color;

  const MoreOptionsButton({
    Key key,
    this.showEditDialog,
    this.color,
    this.textToEdit,
    this.textToDelete,
    this.textToAlertDelete,
    this.delete,
  }) : super(key: key);
  @override
  _MoreOptionsButtonState createState() => _MoreOptionsButtonState();
}

class _MoreOptionsButtonState extends State<MoreOptionsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton(
        child: Icon(
          EvaIcons.moreVertical,
          color: Colors.grey[800],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              textStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: Colors.grey[850],
              ),
              value: 'Editar',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    EvaIcons.edit2,
                    color: widget.color,
                    size: 20,
                  ),
                  SizedBox(width: 16),
                  Text(widget.textToEdit),
                ],
              ),
            ),
            PopupMenuItem(
              textStyle: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: Colors.grey[850],
              ),
              value: 'Excluir',
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    EvaIcons.trash2,
                    color: widget.color,
                    size: 20,
                  ),
                  SizedBox(width: 16),
                  Text(widget.textToDelete),
                ],
              ),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 'Editar') widget.showEditDialog();

          if (value == 'Excluir') {
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
                    widget.textToAlertDelete,
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
                        onPressed: () => widget.delete(context),
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
          }
        },
      ),
    );
  }
}
