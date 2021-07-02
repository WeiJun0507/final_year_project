import 'package:final_year_project/customWidget/registerForm.dart';
import 'package:final_year_project/customWidget/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  void initState() {
    Firebase.initializeApp();
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
              Stack(
                children: [
                  HeaderLayout(
                    title: 'Register',
                    imageUrl: 'assets/image/undraw_cooking_lyxy.png',
                    height: 0.4,
                    top: 0.26,
                    left: 0.37,
                    size: 32.0,
                  ),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: RegisterForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
