import 'package:final_year_project/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String error;

  AuthService _auth = AuthService();

  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        final result =
             await _auth.signInUserWithEmailAndPassword(_email, _password);
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Successful', style: TextStyle(color: Colors.black),),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.greenAccent[100],));
        }
      } on FirebaseAuthException catch (e) {
        print(e);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message, style: TextStyle(color: Colors.white),),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,));
          throw e.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 10.0),
          TextFormField(
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 16.0,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
                prefixIcon: Icon(Icons.email_outlined),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
              },
              onSaved: (value) {
                setState(() {
                  _email = value;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a valid email!';
                }

                if (!RegExp(
                        "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              }),
          SizedBox(height: 10.0),
          TextFormField(
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 16.0,
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
              prefixIcon: Icon(Icons.lock_outline),
              border: InputBorder.none,
            ),
            obscureText: true,
            onChanged: (value) {
              _password = value;
            },
            onSaved: (value) {
              setState(() {
                _password = value;
              });
            },
            validator: (value) => value.length < 6
                ? "Please enter a valid password more than 6 characters!"
                : null,
          ),
          SizedBox(height: 30.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.greenAccent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent[100],
                    offset: Offset(0, 5),
                    blurRadius: 30.0,
                  )
                ]),
            child: TextButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Login',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 20.0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}














