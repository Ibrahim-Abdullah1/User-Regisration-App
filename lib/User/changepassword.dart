import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final c_user = FirebaseAuth.instance.currentUser;
  final _formkey = GlobalKey<FormState>();

  var newpassword = "";
  final _newpasswordcontroller = TextEditingController();

  changePassword() async {
    try {
      await c_user!.updatePassword(newpassword).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Password has been updated',
            style: TextStyle(color: Colors.greenAccent),
          ),
          duration: Duration(seconds: 2),
        ));
      });
      FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/login");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'An Error Accured in changing Password',
          style: TextStyle(color: Colors.redAccent),
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Password";
                } else if (value.length < 6) {
                  return "Password Should be greater than 6 characters";
                }
                return null;
              },
              controller: _newpasswordcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("New PassWord"),
                hintText: "Enter new password",
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () => {
                      if (_formkey.currentState!.validate())
                        {
                          setState(
                            () {
                              newpassword = _newpasswordcontroller.text;
                            },
                          )
                        },
                      changePassword(),
                    },
                child: const Text("Change Password")),
          ),
        ]),
      ),
    );
  }
}
