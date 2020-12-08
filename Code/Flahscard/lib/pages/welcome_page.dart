import 'package:Flahscard/pages/signin.dart';
import 'package:Flahscard/pages/signup.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return WelcomePageWidget();
  }
}

class WelcomePageWidget extends StatefulWidget {
  @override
  _WelcomePageWidgetState createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff622162),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.white24,
                  ),
                  child: Image.asset(
                    "assets/flashly-smile.png",
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "FLASHLY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Uma maneira divertida de\naprender qualquer matéria",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  child: RawMaterialButton(
                    onPressed: () => _buildBottomSheet(true),
                    fillColor: Color(0xffFFA200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Inscreva-se de graça",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                textColor: Color(0xffFF8C00),
                onPressed: () => _buildBottomSheet(false),
                child: Text(
                  "Ou Inicie a sua sessão",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  void _buildBottomSheet(bool isSignUp) {
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
            child: isSignUp ? SignUp() : SignIn(),
          );
        });
  }
}
