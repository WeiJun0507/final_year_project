import 'package:final_year_project/screens/Reservation/reservation_dashboard.dart';
import 'package:flutter/material.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/big-thick.png',height: 80, width: 80, color: Colors.greenAccent[700]),
                SizedBox(height: 10.0,),
                Text('Booking Successful!', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),),
                SizedBox(height: 75.0),
                OutlinedButton(onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }, child: Text('Go back to Home Screen'), style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.greenAccent[700],
                ),)
              ],
            )),
      ),
    );
  }
}
