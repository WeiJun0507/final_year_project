import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Reservation/reservation_admin/reservation_admin_detail_page.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationAdminDashboard extends StatefulWidget {
  const ReservationAdminDashboard({Key key}) : super(key: key);

  @override
  _ReservationAdminDashboardState createState() =>
      _ReservationAdminDashboardState();
}

class _ReservationAdminDashboardState extends State<ReservationAdminDashboard> {
  final _dbService = DatabaseService();

  //create table to database
  int tableNumber;

  void _createTableEverySevenDay() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Quantity of table:'),
              content: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    tableNumber = int.parse(value);
                  });
                },
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      if (tableNumber == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Please enter how many number table you want.',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red[700],
                        ));
                      } else {
                        _dbService.sevenDaysTableCreate(tableNumber);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Create'))
              ],
            ));
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
        title: Text(
          'Reservation Pending List',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.lightBlueAccent,
              ),
              onPressed: () {
                _createTableEverySevenDay();
              }),
        ],
      ),
      body: FutureBuilder(
        future: _dbService.getReservationDetailForAdmin(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Timestamp time = snapshot.data[index]['bookingDate'];
                  DateTime bookedDate = new DateTime.fromMillisecondsSinceEpoch(
                          time.seconds * 1000)
                      .add(Duration(hours: 8));
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReservationAdminDetailPage(
                            customerName: snapshot.data[index]['customerName'],
                            tableId: snapshot.data[index]['tableId'],
                            selectedItem: snapshot.data[index]['selectedItem'],
                            bookedDate: bookedDate,
                            totalPrice: snapshot.data[index]['totalPrice'],
                            comment: snapshot.data[index]['comment'],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Container(
                        width: 65.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.lightBlueAccent,
                        ),
                        child: Center(
                            child: Text(snapshot.data[index]['customerName'])),
                      ),
                      title: Text(
                        snapshot.data[index]['tableId'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Booked Date & Time: ${bookedDate.toString().substring(0, 16)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: snapshot.data[index]['comment'].trim() != ''
                          ? SizedBox(
                              width: 50.0,
                              child: Row(
                                children: [
                                  Icon(Icons.comment,
                                      color: Colors.lightBlue, size: 20.0),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,
                                      size: 20.0)
                                ],
                              ),
                            )
                          : Icon(Icons.arrow_forward_ios_outlined, size: 20.0),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
