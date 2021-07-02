import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayPointCard extends StatelessWidget {
  DisplayPointCard({Key key}) : super(key: key);

  final _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Card(
        elevation: 5.0,
        color: Colors.redAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  'Your current accumulated point:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StreamBuilder(
                    stream: _dbService.getUserLoyaltyPoint(),
                      builder: (context, snapshot) {
                      if(!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return Text(
                          snapshot.data.docs[0]['loyaltyPoint'].toString(),
                          style: TextStyle(
                            fontSize: 42.0,
                            color: Colors.white,
                          ),
                        );
                      }
                      }),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Text(
                    'Point balance',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
