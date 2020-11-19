<<<<<<< HEAD
import 'package:Flahscard/lists.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:Flahscard/widgets/AddEditCard.dart';
import 'package:Flahscard/widgets/AddEditTopic.dart';
=======
import 'package:Flahscard/pages/splash_screen_pages.dart';
>>>>>>> b20329c9a78c1256ec681a79c70664bddc377ba7
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(SplashScreenPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashly',
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flashly"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(),
    );
  }
}
