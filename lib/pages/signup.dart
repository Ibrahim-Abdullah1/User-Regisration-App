import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Widgets/bg_image.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signup> {
  final _formkey = GlobalKey<FormState>();
  // GlobalKey<FormState>? _formkey;

  var email = "";
  var password = "";
  var c_password = "";
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _c_passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _c_passwordcontroller.dispose();
    super.dispose();
  }

  registration() async {
    if (password == c_password) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } catch (e) {}
    } else {}
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
        title: const Text("Signup"),
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
                              errorText: "Invalid Email Input",
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              border: OutlineInputBorder(),
                              label: Text("Password"),
                              hintText: "Enter Password",
                            ),
                          ),
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
                            controller: _c_passwordcontroller,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Confirm Password"),
                              hintText: "ReEnter Password",
                              errorStyle: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            // ignore: non_constant_identifier_names
                            onPressed: () => {
                              if (_formkey.currentState!.validate())
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data'))),
                                  setState(() {
                                    email = _emailcontroller.text;
                                    password = _passwordcontroller.text;
                                    c_password = _c_passwordcontroller.text;
                                  }),
                                },
                              registration(),
                              Navigator.pushNamed(context, '/login'),
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.teal),
                            ),
                            child: const Text("Signup"),
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
