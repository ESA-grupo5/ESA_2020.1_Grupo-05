import 'package:Flahscard/pages/tabs/profilepage.dart';
import 'package:Flahscard/pages/tabs/searchpage.dart';
import 'package:Flahscard/pages/tabs/subjects_page.dart';
import 'package:Flahscard/style/colors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PersistentTabController _controller;
  bool _hideNavBar;
  int _currentIndex = 0;

  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void changeTabControler(index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.jumpToTab(index);
  }

  List<Widget> _buildScreens() {
    return [
      SubjectsPage(),
      Searchpage(),
      Profilepage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon((_currentIndex == 0) ? EvaIcons.copy : EvaIcons.copyOutline),
        // title: ("Cartas"),
        activeColor: colorPrimary,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
            (_currentIndex == 1) ? EvaIcons.search : EvaIcons.searchOutline),
        // title: ("Pesquisar"),
        activeColor: colorPrimary,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
            (_currentIndex == 2) ? EvaIcons.person : EvaIcons.personOutline),
        // title: ("Perfil"),
        activeColor: colorPrimary,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: PersistentTabView(
        onItemSelected: (index) {
          changeIndex(index);
        },
        // padding: NavBarPadding.symmetric(horizontal: 8),
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black26,
              offset: Offset(0, -2),
            )
          ],
        ),
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
