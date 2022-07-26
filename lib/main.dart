// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/pages/forgetpassword.dart';
import 'package:flutter_firebase_demo/pages/home.dart';
import 'package:flutter_firebase_demo/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp(
    debugShowCheckedModeBanner: false,
  )); //runApp
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required bool debugShowCheckedModeBanner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialized = Firebase.initializeApp();

    WidgetsFlutterBinding.ensureInitialized();
    return FutureBuilder(
        future: _initialized,
        builder: (context, Snapshot) {
          switch (Snapshot.connectionState) {
            case ConnectionState.none:
              {
                return const Center(
                  child: Text("Something went Wrong"),
                );
              }

            case ConnectionState.waiting:
              {
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 32),
                );
              }

            case ConnectionState.active:
              {}
              break;

            case ConnectionState.done:
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Firebase Demo",
                  home: AnimatedSplashScreen(
                    splash: Center(
                      child: Text(
                        "Wecome User",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // use any widget here
                    nextScreen: login(),
                    splashTransition: SplashTransition.rotationTransition,
                    duration: 3000,
                  ),
                  theme: ThemeData(
                    primarySwatch: Colors.blueGrey,
                  ),
                  routes: {
                    "/login": (context) => login(),
                    "/signup": (context) => const signup(),
                    "/home": (context) => const homepage(),
                    "/forgetpass": (context) => const forgetpass(),
                  });
          }
          return Center(child: CircularProgressIndicator());
          // :CircularProgressIndicator();
        });
  }
}
