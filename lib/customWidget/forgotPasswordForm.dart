import 'package:final_year_project/services/Auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String _email;

  AuthService _auth = AuthService();

  void _submitForm() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      await _auth.resetPassword(_email);
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
              child: Text('Reset',
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
