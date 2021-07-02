import 'package:final_year_project/customWidget/cEmail.dart';
import 'package:final_year_project/customWidget/cUsername.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:final_year_project/customWidget/loginpage.dart';
import 'package:final_year_project/services/Auth.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {

  User user;

  AuthService _authService = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    user = _auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(children: [
                HeaderLayout(
                    title: 'Change Email',
                    imageUrl: 'assets/image/undraw_cooking_lyxy.png',
                    height: 0.48,
                    top: 0.30,
                    left: 0.30,
                    size: 26.5),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.01,
                  top: MediaQuery.of(context).size.width * 0.08,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.black,
                  ),
                ),
              ]),
              //Adding TextField
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: CEmailForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

