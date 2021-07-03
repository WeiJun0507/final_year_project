import 'package:final_year_project/model/LoyaltyRewards.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';

class LoyaltyPromotionDetailPage extends StatelessWidget {
  final LoyaltyRewards loyaltyRewards;

  LoyaltyPromotionDetailPage({Key key, this.loyaltyRewards}) : super(key: key);

  final _dbService = DatabaseService();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset('assets/image/promotion_icon.png'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Text(
                loyaltyRewards.title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(loyaltyRewards.description),
            ),
            Divider(
              color: Colors.redAccent[700],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Text(
                'Expired Date: ${loyaltyRewards.expiredDate.year}-${loyaltyRewards.expiredDate.month}.${loyaltyRewards.expiredDate.day}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Text(
                'Discount Percentage: ${loyaltyRewards.discountPercentage.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5.0),
              child: Text(
                'Loyalty Point Require: ${loyaltyRewards.loyaltyPoint.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await _dbService
                        .redemptionVoucher(loyaltyRewards.title);
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Redeem Successfully',
                          style: TextStyle(color: Colors.black),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.greenAccent[100],
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Error: Couldn\'t redeem the voucher: Please check your loyalty point amount/ This voucher expired date/ You have redeemed this voucher',
                          style: TextStyle(color: Colors.white),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.redAccent[100],
                      ));
                    }
                  },
                  child: Text(
                    'REDEEM',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent[700],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
