import 'package:flutter/material.dart';

class WelcomePages extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePages> {
  @override
  Widget build(BuildContext context) {
    return WelcomePagesWidget();
  }
}

class WelcomePagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: Colors.white24),
                child: Image.asset(
                  "assets/flashly-happy.png",
                ),
              )),
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
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Color(0xffFFA200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Inscreva-se de graça",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                textColor: Color(0xffFF8C00),
                onPressed: () {
                  // Respond to button press
                },
                child: Text(
                  "Ou Inicie a sua sessão",
                  style: (TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
