import 'package:final_year_project/services/Auth.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CEmailForm extends StatefulWidget {
  const CEmailForm({Key key}) : super(key: key);

  @override
  _CEmailFormState createState() => _CEmailFormState();
}

class _CEmailFormState extends State<CEmailForm> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String error;
  bool isVerified;

  AuthService _auth = AuthService();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseService _dbService = DatabaseService();

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      if (_firebaseAuth.currentUser.email == _email) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'New email cannot be the same as your current email',
            style: TextStyle(color: Colors.black),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.greenAccent[100],
        ));
        return null;
      }

      isVerified = await _auth.verifyCredentials(_password);
      if (isVerified) {
        try {
          _auth.changeEmail(_email);
          _dbService.updateMemberPropertiesinDatabase('email', _email);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Successfully change email.',
              style: TextStyle(color: Colors.black),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.greenAccent[100],
          ));
          Navigator.pop(context);
        } on FirebaseException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              e.message,
              style: TextStyle(color: Colors.black),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.greenAccent[100],
          ));
          Navigator.pop(context);
        }
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
                hintText: 'New Email',
                hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
                prefixIcon: Icon(Icons.contact_page_outlined),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                  _email = value;
              },
              onSaved: (value) {
                _email = value;
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
              }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize: 16.0,
              ),
              hintText: 'password',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
              prefixIcon: Icon(Icons.lock_outline),
              border: InputBorder.none,

            ),
            obscureText: true,
            onChanged: (value) {
              _password = value;
            },
            onSaved: (value) {
              _password = value;
            },
            validator: (value) =>
            value.length < 6
                ? "Please enter a valid password more than 6 characters!"
                : null,
          ),
          SizedBox(height: 15.0),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.35,
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
