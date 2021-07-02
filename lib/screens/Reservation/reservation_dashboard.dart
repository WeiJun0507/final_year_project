import 'package:final_year_project/screens/Reservation/reservation_detail/check_reservation_detail.dart';
import 'package:final_year_project/screens/Reservation/reservation_booking/reservation_booking_dashboard.dart';
import 'package:flutter/material.dart';

//two options
//Make reservation
//See Reservation detail

class ReservationDashboard extends StatelessWidget {
  const ReservationDashboard({Key key}) : super(key: key);

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
              color: Colors.blueAccent,
              size: 18.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Text('Select Option: ', style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationBookingPage()));
                    },
                    icon: Icon(Icons.description_outlined),
                    label: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Make New Reservation', style: TextStyle(
                        fontSize: 18.0,
                      ),),
                    ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                ),),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('OR'),
                ),
              ),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckReservationDetail()));
                    },
                    icon: Icon(Icons.wysiwyg_outlined, color: Colors.blueAccent,),
                    label: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Check Reservation Detail', style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0.0
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
