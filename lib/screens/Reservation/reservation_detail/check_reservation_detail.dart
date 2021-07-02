import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/screens/Reservation/reservation_detail/reservation_detail_page.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckReservationDetail extends StatefulWidget {
  CheckReservationDetail({Key key}) : super(key: key);

  @override
  _CheckReservationDetailState createState() => _CheckReservationDetailState();
}

class _CheckReservationDetailState extends State<CheckReservationDetail> {
  final _dbService = DatabaseService();

  final _auth = FirebaseAuth.instance;

  void deleteReservation(String customerId, String tableId, DateTime date,
      int bookingTime, bool isBooked) {
    _dbService
        .deleteBooking(
        customerId,
        tableId,
        date,
        bookingTime,
        isBooked)
        .then((_) {
      _dbService
          .unCheckedBookingStatus(
          date,
          tableId,
          bookingTime);
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
              color: Colors.blueAccent,
              size: 18.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: FutureBuilder(
              future: _dbService.getCurrentOrderDetail(_auth.currentUser.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'On Going Reservation:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Timestamp time =
                                  snapshot.data[index]['bookingDate'];
                              DateTime bookedDate =
                                  new DateTime.fromMillisecondsSinceEpoch(
                                          time.seconds * 1000)
                                      .add(Duration(hours: 8));
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 2.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReservationDetailPage(
                                                    tableId:
                                                        snapshot.data[index][
                                                            'tableId'],
                                                    bookedDate: bookedDate,
                                                    comment:
                                                        snapshot.data[index]
                                                            ['comment'],
                                                    selectedFood: snapshot.data[
                                                        index]['selectedItem'],
                                                    totalPrice:
                                                        snapshot.data[index]
                                                            ['totalPrice'])));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Card(
                                      elevation: 4.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              'Reserved Table: ${snapshot.data[index]['tableId']}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 5.0),
                                            child: Text(
                                              'Booked Time: ${bookedDate.toString().substring(0, 16)}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 5.0),
                                            child: Text(
                                              'Preorder Food cost: RM${snapshot.data[index]['totalPrice']}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .delete_outline_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {

                                                    showDialog(context: context, builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('Cancellation Confirm', style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                        content: Text('Are you sure you want to cancel this booking?', style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),),
                                                        actions: [
                                                          TextButton(onPressed: () {
                                                            setState(() {
                                                              deleteReservation(_auth.currentUser.uid,
                                                                  snapshot.data[index]['tableId'],
                                                                  bookedDate,
                                                                  snapshot.data[index]['selectedTime'],
                                                                  false);
                                                            });
                                                            Navigator.pop(context);
                                                          }, child: Text('YES', style: TextStyle(
                                                            color: Colors.red,
                                                          ),)),
                                                          TextButton(onPressed: () {
                                                            Navigator.pop(context);
                                                          }, child: Text('No', style: TextStyle(
                                                            color: Colors.blue,
                                                          ),)),
                                                        ],
                                                      );
                                                    });

                                                  })
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.49,
            child: FutureBuilder(
              future: _dbService.getPastOrderDetail(_auth.currentUser.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Past Reservation:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Timestamp time =
                                  snapshot.data[index]['bookingDate'];
                              DateTime bookedDate =
                                  new DateTime.fromMillisecondsSinceEpoch(
                                          time.seconds * 1000)
                                      .add(Duration(hours: 8));
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 4.0,
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 2.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReservationDetailPage(
                                                    tableId:
                                                        snapshot.data[index][
                                                            'tableId'],
                                                    bookedDate: bookedDate,
                                                    comment:
                                                        snapshot.data[index]
                                                            ['comment'],
                                                    selectedFood: snapshot.data[
                                                        index]['selectedItem'],
                                                    totalPrice:
                                                        snapshot.data[index]
                                                            ['totalPrice'])));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Card(
                                      elevation: 4.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 10.0),
                                            child: Text(
                                              'Reserved Table: ${snapshot.data[index]['tableId']}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 5.0),
                                            child: Text(
                                              'Booked Time: ${bookedDate.toString().substring(0, 16)}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 5.0),
                                            child: Text(
                                              'Preorder Food cost: RM${snapshot.data[index]['totalPrice']}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
