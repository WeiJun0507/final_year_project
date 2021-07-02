import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/provider.dart';
import 'package:final_year_project/screens/authenticate/login_page.dart';
import 'package:final_year_project/screens/dashboard/home.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Member>(context);

    return user != null ? HomeApp() : SignIn();
  }


}
