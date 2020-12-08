import 'package:Flahscard/constants.dart';
import 'package:Flahscard/database/controllers/users_ctr.dart';
import 'package:Flahscard/functions/account.dart';
import 'package:Flahscard/models/user.dart';
import 'package:Flahscard/pages/welcome_page.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  User _user = User();
  LoginCtr _controller = LoginCtr();

  @override
  initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    User user =
        await _controller.getUser(userIdConstant).then((value) => value);
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: colorPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child: Center(
                  child: IconButton(
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      EvaIcons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 57.5,
                    child: Icon(
                      EvaIcons.imageOutline,
                      size: 57.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${_user.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${_user.email}',
                    style: TextStyle(
                      color: Colors.white30,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child: Center(
                  child: IconButton(
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      EvaIcons.logOut,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            title: Text(
                              'Sair',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            content: Text(
                              "Tem certeza que deseja sair do Flashly?",
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
                                    color: colorPrimary,
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
                                  color: colorPrimary,
                                  onPressed: () async =>
                                      await logOut().then((value) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                WelcomePage()),
                                        (route) => false);
                                  }),
                                  child: Text(
                                    'SAIR',
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
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        )
      ],
    ));
  }
}
