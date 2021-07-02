import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/LoyaltyProgram/customer_loyalty_dashboard.dart';
import 'package:final_year_project/services/Database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_loyalty_dashboard.dart';

class LoyaltyDashboard extends StatefulWidget {
  LoyaltyDashboard({Key key}) : super(key: key);

  @override
  _LoyaltyDashboardState createState() => _LoyaltyDashboardState();
}

class _LoyaltyDashboardState extends State<LoyaltyDashboard> {
  final _dbService = DatabaseService();
  bool admin = false;

  @override
  void initState() {
    super.initState();
    getUserAdmin();
  }

  void getUserAdmin() async {
    Member user = await _dbService.getCurrentUserInfo();

    if (user.admin != null) {
      setState(() {
        admin = true;
      });
    } else {
      setState(() {
        admin = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.redAccent[400],
                size: 16.0,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body:
        admin ?
            AdminLoyaltyDashboard()
            : CustomerLoyaltyDashboard(),
    );
  }
}
