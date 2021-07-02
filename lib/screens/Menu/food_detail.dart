import 'package:final_year_project/screens/Reservation/reservation_dashboard.dart';
import 'package:flutter/material.dart';

class FoodDetail extends StatelessWidget {
  final Map<String, dynamic> object;

  const FoodDetail({Key key, this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        title: Text(
          object['name'],
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.green,
              size: 16.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.network(object['picture']),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
              child: Text(
                'Ingredients:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(object['description'],
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[700],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, top: 10.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Divider(thickness: 1, color: Colors.black45)),
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RM ${object['price']}',
                      style: TextStyle(
                        fontSize: 35.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Price does not include Service Charge',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReservationDashboard()));
                },
                child: Text(
                  'Book Now!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
