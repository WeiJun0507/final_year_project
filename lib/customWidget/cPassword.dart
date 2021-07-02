import 'package:final_year_project/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CPasswordForm extends StatefulWidget {
  const CPasswordForm({Key key}) : super(key: key);

  @override
  _CPasswordFormState createState() => _CPasswordFormState();
}

class _CPasswordFormState extends State<CPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _oldPassword;
  String _newPassword;
  String _confirmNewPassword;
  String error;
  bool isVerified;

  AuthService _auth = AuthService();

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      //check oldPassword should not be the same as new password
      if (_oldPassword != _newPassword) {
        try {
          isVerified = await _auth.verifyCredentials(_oldPassword);
          if (isVerified) {
            await _auth.changePassword(_newPassword);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Successfully change password.',
                style: TextStyle(color: Colors.black),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.greenAccent[100],
            ));
            Navigator.pop(context);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                e.message.toString(),
                style: TextStyle(color: Colors.black),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.greenAccent[100],
            ));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Old and new password cannot be same',
              style: TextStyle(color: Colors.black),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.greenAccent[100]));
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
              hintText: 'Your old password',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
              prefixIcon: Icon(Icons.lock_outline),
              border: InputBorder.none,
            ),
            obscureText: true,
            onChanged: (value) {
              _oldPassword = value;
              print(value);
            },
            onSaved: (value) {
              setState(() {
                _oldPassword = value;
              });
            },
            validator: (value) => value.length < 6
                ? "Please enter a valid password more than 6 characters!"
                : null,
          ),
          SizedBox(height: 15.0),
          TextFormField(
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 16.0,
              ),
              hintText: 'New Password',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
              prefixIcon: Icon(Icons.lock_outline),
              border: InputBorder.none,
            ),
            obscureText: true,
            onChanged: (value) {
              _newPassword = value;
              print(value);
            },
            onSaved: (value) {
              setState(() {
                _newPassword = value;
              });
            },
            validator: (value) => value.length < 6
                ? "Please enter a valid password more than 6 characters!"
                : null,
          ),
          SizedBox(height: 15.0),
          TextFormField(
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 16.0,
                ),
                hintText: 'Confirm new password',
                hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
                prefixIcon: Icon(Icons.lock_outline),
                border: InputBorder.none,
              ),
              obscureText: true,
              onChanged: (value) {
                _confirmNewPassword = value;
                print(value);
              },
              onSaved: (value) {
                setState(() {
                  _confirmNewPassword = value;
                });
              },
              validator: (value) {
                if (value.length < 6) {
                  return "Please enter a valid password more than 6 characters!";
                }

                if (_newPassword != value) {
                  return "Password is not match!";
                }
                return null;
              }),
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
              child: Text('Update',
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
