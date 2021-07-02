import 'package:final_year_project/customWidget/profileOption.dart';
import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Profile/settings/settings.dart';
import 'package:final_year_project/screens/wrapper/wrapper.dart';
import 'package:final_year_project/services/Auth.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';

import 'aboutPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseService _dbService = DatabaseService();
  AuthService _auth = AuthService();

  Member curUserInfo;

  @override
  void initState() {
    displayUserInfo();
    super.initState();
  }

  void displayUserInfo() {
    //Map the value into each field
    _dbService.getCurrentUserInfo().then((value) => setState(() {
      curUserInfo = value;
    }));
  }

  @override
  void didChangeDependencies() {
    displayUserInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[900],
          elevation: 0.0,
          title: Text(
            'PROFILE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: curUserInfo == null ? Center(child : CircularProgressIndicator()) : Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.yellow[900],
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                            "Username : ${curUserInfo.username}" ?? 'Undefined',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 10.0),
                        Text(
                          "Loyalty Point : ${curUserInfo.loyaltyPoint}" ??
                              '0.0',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        CircleAvatar(
                            radius: 50,
                            child: Text(
                                curUserInfo.username[0] +
                                    curUserInfo.username[1],
                                style: TextStyle(
                                  fontSize: 40.0,
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ProfileOption(
              title: 'SETTINGS',
              customIcon: Icons.settings_rounded,
              onCalled: () {
                final result = Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
                if (result != null) {
                  setState(() {

                  });
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ProfileOption(
              title: 'ABOUT',
              customIcon: Icons.announcement_outlined,
              onCalled: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
            },),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ProfileOption(title: 'LOG OUT', customIcon: Icons.logout,
            onCalled: () {
              setState(() {
                _auth.logout();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
              });
            },),
          ],
        ));
  }
}
