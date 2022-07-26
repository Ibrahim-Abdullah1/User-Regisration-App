import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Widgets/bg_image.dart';
import 'package:flutter_firebase_demo/pages/home.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formkey = GlobalKey<FormState>();

  var email = "";

  var password = "";

  final _emailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  user_login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'null') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Enter Email or Password',
            style: TextStyle(color: Colors.redAccent),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'User Email Not Found',
            style: TextStyle(color: Colors.redAccent),
          ),
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Incorrect Password...Try Again!!!',
            style: TextStyle(color: Colors.redAccent),
          ),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Invalid Input...Try Again!!!',
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
        title: const Text("Login Page"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const bg_image(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formkey,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
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
                                label: Text("UserName"),
                                hintText: "Enter User Name",
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              )),
                          const SizedBox(height: 25),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              } else if (value.length < 6) {
                                return "Password Should be greater than 6 characters";
                              }
                              return null;
                            },
                            controller: _passwordcontroller,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Password"),
                              hintText: "Enter Password",
                              errorStyle: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => {
                                  setState(
                                    () {
                                      if (_formkey.currentState!.validate()) {
                                        email = _emailcontroller.text;
                                        password = _passwordcontroller.text;
                                      }
                                      ;
                                    },
                                  ),
                                  user_login(),
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.teal),
                                ),
                                child: const Text("Login"),
                              ),
                              const SizedBox(
                                width: 26,
                              ),
                              TextButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/forgetpass");
                                    Colors.green;
                                  },
                                  child: const Text("forget Password??")),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 14.1, color: Colors.blueGrey),
                              ),
                              TextButton(
                                  onPressed: (() {
                                    Navigator.pushReplacementNamed(
                                        context, '/signup');
                                  }),
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(color: Colors.blueGrey),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
