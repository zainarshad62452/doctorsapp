import 'dart:async';
import 'dart:ui';
import 'package:doctorsapp/screens/doctor/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:doctorsapp/firestore-data/searchList.dart';
import 'package:doctorsapp/screens/user/homePage.dart';
import 'package:doctorsapp/screens/user/myAppointments.dart';
import 'package:doctorsapp/screens/user/userProfile.dart';
import 'package:doctorsapp/screens/doctor/patientsList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:quick_actions/quick_actions.dart';

import '../user/doctorProfile.dart';
import 'homePage.dart';
import 'myAppointments.dart';

class DoctorMainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<DoctorMainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _pages = [
    DoctorHomePage(),
    DoctorAppointments(title: "My Appointments"),
    DoctorMainProfile(),
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                haptic: true,
                tabBorderRadius: 20,
                gap: 5,
                activeColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                // tabBackgroundColor: Colors.blue.withOpacity(0.7),
                tabBackgroundColor: Colors.tealAccent.shade700,
                textStyle: GoogleFonts.lato(
                  color: Colors.white,
                ),
                tabs: [
                  GButton(
                    iconSize: _selectedIndex != 0 ? 28 : 25,
                    icon: _selectedIndex == 0
                        ? CupertinoIcons.home
                        : CupertinoIcons.house_fill,
                    text: 'Home',
                  ),
                  GButton(
                    iconSize: 28,
                    icon: _selectedIndex == 2
                        ? Typicons.calendar
                        : Typicons.calendar_outline,
                    text: 'Schedule',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: _selectedIndex == 3
                        ? Typicons.user
                        : Typicons.user_outline,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
