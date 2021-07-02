import 'package:final_year_project/screens/wrapper/wrapper.dart';
import 'package:final_year_project/services/Auth.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class CUsernameForm extends StatefulWidget {
  const CUsernameForm({Key key}) : super(key: key);

  @override
  _CUsernameFormState createState() => _CUsernameFormState();
}

class _CUsernameFormState extends State<CUsernameForm> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String error;

  AuthService _auth = AuthService();
  DatabaseService _dbService = DatabaseService();

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      try {
        _auth.changeUsername(_username);
        _dbService.updateMemberPropertiesinDatabase('username', _username);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Successfully change username.',
            style: TextStyle(color: Colors.black),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.greenAccent[100],
        ));
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
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
              hintText: 'New Username',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 20),
              prefixIcon: Icon(Icons.contact_page_outlined),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _username = value;
            },
            onSaved: (value) {
              _username = value;
            },
            validator: (value) => value.isEmpty ? 'New username cannot be empty' : null
          ),
          SizedBox(height: 15.0),
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
