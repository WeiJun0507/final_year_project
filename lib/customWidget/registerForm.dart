import 'package:final_year_project/provider.dart';
import 'package:final_year_project/screens/wrapper/wrapper.dart';
import 'package:final_year_project/services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _email;
  String _password;
  String _confirmPassword;

  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      try {
        await _auth
            .registerUserWithEmailAndPassword(
            _email, _password, _username);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Wrapper()));
      } catch (e) {
        print(e);
      }
    }
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 16.0,
              ),
              hintText: 'Username',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
              prefixIcon: Icon(Icons.perm_contact_cal_outlined),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _username = value;
            },
            onSaved: (value) {
              setState(() {
                _username = value;
              });
            },
            validator: (value) =>
                value.isEmpty ? "Please enter a valid username!" : null,
          ),
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
            validator: (value) =>
            value.length < 6 ? "Please enter a valid password!" : null,
          ),
          SizedBox(height: 10.0),
          TextFormField(
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 16.0,
                ),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
                prefixIcon: Icon(Icons.lock_outline),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              onSaved: (value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
              obscureText: true,
              validator: (value) {
                if (value.length < 6) {
                  return 'Password is less than 6 characters!';
                }
                if (_password != value) {
                  return 'Password is not match!';
                }
                return null;
              }),
          SizedBox(height: 20.0),
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
              onPressed: () async {
                _submitForm();

              },
              child: Text('Register',
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
