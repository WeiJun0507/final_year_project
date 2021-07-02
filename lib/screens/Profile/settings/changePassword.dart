import 'package:final_year_project/customWidget/cPassword.dart';
import 'package:final_year_project/customWidget/forgotPasswordForm.dart';
import 'package:final_year_project/customWidget/loginpage.dart';
import 'package:final_year_project/services/Auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String email;


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
                    title: 'Change Password',
                    imageUrl: 'assets/image/undraw_cooking_lyxy.png',
                    height: 0.48,
                    top: 0.27,
                    left: 0.227,
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
                child: CPasswordForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
