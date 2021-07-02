import 'package:final_year_project/customWidget/loginForm.dart';
import 'package:final_year_project/customWidget/loginpage.dart';
import 'package:final_year_project/screens/authenticate/forgot_password.dart';
import 'package:final_year_project/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;
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
                      title: 'Login',
                      imageUrl: 'assets/image/undraw_cooking_lyxy.png',
                      height: 0.48,
                      top: 0.3,
                      left: 0.41,
                      size: 32.0),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.04,
                      right: MediaQuery.of(context).size.width * 0.05,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.greenAccent[700],
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          )))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: LoginForm(),
              ),
              TextButton(
                child: Text('Forgot Password?',
                    style: TextStyle(
                      color: Colors.greenAccent[400],
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPassword()));
                },
              ),

            ],
          ),
        ),
      ),
    );

  }
}
