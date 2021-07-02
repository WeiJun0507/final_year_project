import 'package:final_year_project/customWidget/customPromotionCard.dart';
import 'package:final_year_project/model/LoyaltyRewards.dart';
import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Reservation/reservation_dashboard.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display_point_Card.dart';

class CustomerLoyaltyDashboard extends StatefulWidget {
  CustomerLoyaltyDashboard({Key key}) : super(key: key);

  @override
  _CustomerLoyaltyDashboardState createState() =>
      _CustomerLoyaltyDashboardState();
}

class _CustomerLoyaltyDashboardState extends State<CustomerLoyaltyDashboard> {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  double _loyaltyPoint;

  @override
  void initState() {
    super.initState();
    getMemberPoint();
  }

  @override
  void didChangeDependencies() {
    setState(() {
    });
    super.didChangeDependencies();
  }

  void getMemberPoint() async {
    final result = await _dbService.getCurrentUserInfo();
    Map<String, dynamic> data = result.toJson();

    setState(() {
      _loyaltyPoint = double.parse(data['loyaltyPoint']);
    });
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
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dearest',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _auth.currentUser.displayName ?? 'Undefined',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent[400],
                      ),
                    ),
                    Text('  customers',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationDashboard()));
                          }, child: Text('Book Now!', style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                          ),))
                        ],
                      ),
                      DisplayPointCard(),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      //A carousel slider that maximum only fetch three item
                      Container(
                        height: MediaQuery.of(context).size.height * 0.265,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: StreamBuilder(
                              stream: _dbService.getLoyaltyProgramPromotion(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      final rewards = LoyaltyRewards.fromJson(
                                          snapshot.data.docs[index].data());
                                      return CustomPromotionCard(
                                          loyaltyRewards: rewards);
                                    },
                                  );
                                }
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Redeemed Voucher: ', style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange
                        ),),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: StreamBuilder(
                          stream: _dbService.getRedeemedVoucher(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child:ListTile(
                                            leading: Icon(Icons.local_offer_outlined),
                                            title: Text(snapshot.data.docs[index]['voucherName']),
                                          ),
                                        );
                                  });
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
