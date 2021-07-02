import 'package:final_year_project/model/LoyaltyRewards.dart';
import 'package:final_year_project/screens/LoyaltyProgram/loyalty_promotion_detail_page.dart';
import 'package:flutter/material.dart';

class CustomPromotionCard extends StatelessWidget {
  final LoyaltyRewards loyaltyRewards;

  const CustomPromotionCard(
      {Key key, this.loyaltyRewards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.225,
        child: Card(
          color: Colors.redAccent,
          elevation: 6.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoyaltyPromotionDetailPage(loyaltyRewards: loyaltyRewards)));
            },
            child: Column(
              children: [
                SizedBox(height:8.0),
                Text(
                  loyaltyRewards.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    loyaltyRewards.description.split('.')[0],
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Spacer(),
                      Text('Discount Percentage: ', style: TextStyle(
                        color: Colors.white,
                      ),),
                      Text(loyaltyRewards.discountPercentage.toString(), style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                ),
                Spacer(),
                Divider(thickness: 1,),
                ListTile(
                  title: Text('Promotion Discount', style: TextStyle(
                    color: Colors.white,
                  ),),
                  trailing: Text(
                    'View More',
                    style: TextStyle(
                      color: Colors.cyanAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
