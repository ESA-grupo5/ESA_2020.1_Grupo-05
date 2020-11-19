import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenWidget(),
    );
  }
}

class SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 4,
            backgroundColor: Color(0xff622162),
            navigateAfterSeconds: "",
            loaderColor: Colors.transparent,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Center(
                  child: Container(
                child: Image.asset(
                  "assets/flashly-happy.png",
                  height: 150,
                  width: 150,
                ),
              )),
              Spacer(),
              Text(
                "FLASHLY",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }
}
