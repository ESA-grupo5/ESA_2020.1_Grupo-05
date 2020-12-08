import 'package:Flahscard/style/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<Widget> containers = [
    Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/search_1.svg"),
            SizedBox(height: 16),
            Text(
              "Digite uma matéria\nDica: quanto mais específico, melhor!",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff9E9E9E),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
    Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/search_2.svg"),
            SizedBox(height: 16),
            Text(
              "Digite um assunto ou tema\nDica: quanto mais específico, melhor!",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff9E9E9E),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
    Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/search_3.svg"),
            SizedBox(height: 16),
            Text(
              "Procurando por algum colega?\nDigite o nome de usuário que ele(a)\nutiliza",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff9E9E9E),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    ),
  ];

  Widget _buildPageForSearch(String imagePath, String message) {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        currentFocus.unfocus();
      },
      child: DefaultTabController(
        length: containers.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            toolbarHeight: 150,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                SizedBox(height: 32),
                Text(
                  "PESQUISAR",
                  style: GoogleFonts.quicksand().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xff85ADBB).withOpacity(0.25),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                EvaIcons.searchOutline,
                                color: Color(0xff85ADBB),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              labelColor: Colors.grey[800],
              unselectedLabelColor: Colors.grey,
              indicatorColor: colorPrimary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Text(
                    "MATÉRIAS",
                    style: GoogleFonts.quicksand().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "ASSUNTOS",
                    style: GoogleFonts.quicksand().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "USUÁRIOS",
                    style: GoogleFonts.quicksand().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildPageForSearch('assets/images/search_1.png',
                  "Digite uma matéria\nDica: quanto mais específico, melhor!"),
              _buildPageForSearch('assets/images/search_2.png',
                  "Digite um assunto ou tema\nDica: quanto mais específico, melhor!"),
              _buildPageForSearch('assets/images/search_3.png',
                  "Procurando por algum colega?\nDigite o nome de usuário que ele(a)\nutiliza."),
            ],
          ),
        ),
      ),
    );
  }
}
