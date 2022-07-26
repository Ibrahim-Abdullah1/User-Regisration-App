import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({Key? key}) : super(key: key);

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final _formkey = GlobalKey<FormState>();
  var _email = "";
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  recoverpassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Check your Email Inbox to recover password',
          style: TextStyle(color: Colors.green),
        ),
        duration: Duration(seconds: 3),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Email not found',
            style: TextStyle(color: Colors.redAccent),
          ),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamed(context, "/login");
          },
        ),
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Enter Email Where you can recieve Password Recovery Link Via Email",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 25,
            ),
            Form(
              key: _formkey,
              child: Column(children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Email";
                    } else if (!value.contains("@")) {
                      return "Please Enter Valid Email";
                    }
                    return null;
                  },
                  controller: _emailcontroller,
                  decoration: const InputDecoration(
                    labelText: "Enter Mail",
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        _email = _emailcontroller.text;
                      });
                      recoverpassword();
                    }),
                    child: Text(
                      "Send",
                      style: TextStyle(foreground: Paint()),
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
