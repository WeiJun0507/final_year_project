import 'package:final_year_project/customWidget/profileOption.dart';
import 'package:final_year_project/screens/Profile/profile.dart';
import 'package:flutter/material.dart';

import 'changeEmail.dart';
import 'changePassword.dart';
import 'changeUsername.dart';

class Setting extends StatelessWidget {
  const Setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_outlined,
            color: Colors.green[700],
          ),
          onTap: () {
            Navigator.of(context).pop(Colors.white);
          },),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            ProfileOption(
              title: 'Change Username',
              customIcon: Icons.contact_mail_outlined,
              onCalled: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeUsername()));
              },
            ),
            SizedBox(height: 25.0,),
            ProfileOption(
              title: 'Change Email',
              customIcon: Icons.email_outlined,
              onCalled: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeEmail()));
              },
            ),
            SizedBox(height: 25.0,),
            ProfileOption(
              title: 'Change Password',
              customIcon: Icons.lock_outline,
              onCalled: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
