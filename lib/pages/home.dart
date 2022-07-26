// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/User/changepassword.dart';
import 'package:flutter_firebase_demo/User/dashboard.dart';
import 'package:flutter_firebase_demo/User/profile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var _selectedindex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Profile(),
    ChangePassword(),
  ];

  void _ontap(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async => {
                      await FirebaseAuth.instance.signOut(),
                      Navigator.pushReplacementNamed(context, "/login")
                    },
                icon: const Icon(Icons.exit_to_app))
          ],
          title: const Text("Home Page"),
        ),
        body: _widgetOptions.elementAt(_selectedindex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Change password",
            ),
          ],
          currentIndex: _selectedindex,
          selectedFontSize: 20.7,
          selectedIconTheme:
              const IconThemeData(color: Colors.greenAccent, size: 20.7),
          onTap: _ontap,
        ));
  }
}
