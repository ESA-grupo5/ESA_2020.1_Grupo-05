import 'package:Flahscard/database/controllers/subjects_ctr.dart';
import 'package:Flahscard/database/controllers/topics_ctr.dart';
import 'package:Flahscard/database/controllers/users_ctr.dart';
import 'package:Flahscard/models/subject.dart';
import 'package:Flahscard/models/topic.dart';
import 'package:Flahscard/models/user.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage>
    with SingleTickerProviderStateMixin {
  String searchText = '';
  TextEditingController textEditingController = new TextEditingController();
  int categoryId = 0;

  TabController _tabController;

  Future<List<Subject>> _materias;
  Future<List<Topic>> _assuntos;
  Future<List<User>> _usuarios;

  SubjectsCtr _subjectsCtr = SubjectsCtr();
  TopicsCtr _topicsCtr = TopicsCtr();
  LoginCtr _loginCtr = LoginCtr();

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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: containers.length);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging)
        setState(() => categoryId = _tabController.index);
      else if (_tabController.index != _tabController.previousIndex)
        setState(() => categoryId = _tabController.index);
    });
    _updateAllLists();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _updateSubjectsList() {
    setState(() {
      _materias = _subjectsCtr.getAllSubjectsByName(searchText);
    });
  }

  _updateTopicList() {
    setState(() {
      _assuntos = _topicsCtr.getAllTopicsByName(searchText);
    });
  }

  _updateUsersList() {
    setState(() {
      _usuarios = _loginCtr.getAllUserByName(searchText);
    });
  }

  _updateAllLists() {
    _updateSubjectsList();
    _updateTopicList();
    _updateUsersList();
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
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xff85ADBB).withOpacity(0.25),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 16),
                              border: InputBorder.none,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Icon(
                                  EvaIcons.search,
                                  color: Color(0xff85ADBB),
                                ),
                              ),
                              suffixIcon: (searchText != "")
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchText = "";
                                          textEditingController.clear();
                                        });
                                      },
                                      icon: Icon(
                                        EvaIcons.close,
                                        color: Color(0xff85ADBB),
                                      ),
                                      iconSize: 20,
                                    )
                                  : Container(width: 1, height: 1),
                            ),
                            onChanged: (text) {
                              setState(() => searchText = text.toLowerCase());
                              _updateAllLists();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
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
            controller: _tabController,
            children: [
              FutureBuilder(
                  future: _materias,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.length > 0 &&
                        searchText != "") {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              snapshot.data[index].name,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return _buildPageForSearch('assets/images/search_1.png',
                        "Digite uma matéria\nDica: quanto mais específico, melhor!");
                  }),
              FutureBuilder(
                  future: _assuntos,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.length > 0 &&
                        searchText != "") {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            dense: true,
                            title: Row(
                              children: [
                                Icon(
                                  EvaIcons.folder,
                                  color: snapshot.data[index].color,
                                ),
                                SizedBox(width: 16),
                                Flexible(
                                  child: Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return _buildPageForSearch('assets/images/search_2.png',
                        "Digite um assunto ou tema\nDica: quanto mais específico, melhor!");
                  }),
              FutureBuilder(
                  future: _usuarios,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.length > 0 &&
                        searchText != "") {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            dense: true,
                            title: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CircleAvatar(
                                    child: Icon(EvaIcons.imageOutline),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        snapshot.data[index].email,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return _buildPageForSearch('assets/images/search_3.png',
                        "Procurando por algum colega?\nDigite o nome de usuário que ele(a)\nutiliza.");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
