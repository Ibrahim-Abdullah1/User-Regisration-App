import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userid = FirebaseAuth.instance.currentUser!.uid;
  final usermail = FirebaseAuth.instance.currentUser!.email;
  final created = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyemail() async {
    if (user != null && !user!.emailVerified) {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Verification Email is Sended to your Account.',
          style: TextStyle(color: Colors.greenAccent),
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Your Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("User Id: $userid"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Email: $usermail"),
              user!.emailVerified
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Verified",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    )
                  : TextButton(
                      onPressed: (() {
                        setState(() {
                          verifyemail();
                        });
                      }),
                      child: Text(
                        "verify email",
                        style: TextStyle(color: Colors.blueGrey),
                      )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Created on : $created"),
        ),
      ],
    );
  }
}
