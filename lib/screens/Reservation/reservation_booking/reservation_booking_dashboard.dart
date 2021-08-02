import 'dart:ui';
import 'package:final_year_project/provider.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'checkout_menu_page.dart';

class ReservationBookingPage extends StatefulWidget {
  const ReservationBookingPage({Key key}) : super(key: key);

  @override
  _ReservationBookingPageState createState() => _ReservationBookingPageState();
}

class _ReservationBookingPageState extends State<ReservationBookingPage> {
  DateTime _currentDate = DateTime.now();
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;

  //selected Table number
  String selectedTable;
  int selectedTime = 9;

  @override
  void initState() {
    checkCurrentTime(DateTime.now());
    super.initState();
  }

  void checkCurrentTime(DateTime date) {
    print(date.hour);
    if (date.hour < 9) {
      setState(() {
        selectedTime = 9;
      });
    } else if (date.hour < 11) {
      setState(() {
        selectedTime = 11;
      });
    } else if (date.hour < 13) {
      setState(() {
        selectedTime = 13;
      });
    } else if (date.hour < 15) {
      setState(() {
        selectedTime = 15;
      });
    } else if (date.hour < 17) {
      setState(() {
        selectedTime = 17;
      });
    } else if (date.hour < 19) {
      setState(() {
        selectedTime = 19;
      });
    } else {
      setState(() {
        selectedTime = 9;
        _currentDate = new DateTime(date.year, date.month, date.day)
            .add(Duration(days: 1));
      });
    }
  }

  List<Map<String, dynamic>> availableTime = [
    {'index': 0, 'time': 9},
    {'index': 1, 'time': 11},
    {'index': 2, 'time': 13},
    {'index': 3, 'time': 15},
    {'index': 4, 'time': 17},
    {'index': 5, 'time': 19}
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: _currentDate,
        lastDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(Duration(days: 7)));
    if (pickedDate != null && pickedDate != _currentDate)
      setState(() {
        _currentDate = pickedDate;
      });
  }

  void _onSelectTime(int index) {
    setState(() {
      availableTime.forEach((element) {
        if (element['index'] == index) {
          selectedTime = element['time'];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _reservationProvider = Provider.of<ReservationInformation>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        color: Colors.indigo[300],
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Select Date : ',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              style: OutlinedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(40.0),
                                ),
                                side: BorderSide(
                                  color: Colors.lightBlueAccent,
                                  style: BorderStyle.solid,
                                  width: 2,
                                ),
                                primary: Colors.lightBlueAccent,
                                elevation: 0.0,
                              ),
                              child: Text(
                                '${_currentDate.year}-${_currentDate.month}.${_currentDate.day}',
                                style: TextStyle(
                                    color: Colors.lightBlueAccent[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    letterSpacing: 2),
                              ),
                            ),
                          ),
                          flex: 5,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Text(
                        'Time Reservation:',
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return _currentDate.hour > selectedTime
                              ? Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.lightBlueAccent[700],
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: Center(
                                      child: Text(
                                        '${availableTime[index]['time']}:00 - ${availableTime[index]['time'] + 2}:00',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: selectedTime ==
                                                  availableTime[index]['time']
                                              ? Colors.greenAccent[700]
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    if (_currentDate.hour > availableTime[index]['time']) return;
                                    _onSelectTime(index);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.lightBlueAccent[700],
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      child: Center(
                                        child: Text(
                                          '${availableTime[index]['time']}:00 - ${availableTime[index]['time'] + 2}:00',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: selectedTime ==
                                                    availableTime[index]['time']
                                                ? Colors.greenAccent[700]
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                  ]),
            ),
            SizedBox(height: 15.0),
            Text(
              'Table Display:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
              child: Container(
                height: 340,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xff2A2E37),
                ),
                child: FutureBuilder(
                    future: _dbService.getTableAmount(DateTime(
                        _currentDate.year,
                        _currentDate.month,
                        _currentDate.day)),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.count(
                          childAspectRatio: 100 / 65,
                          crossAxisCount: 3,
                          children:
                              List.generate(snapshot.data.length, (index) {
                            return FutureBuilder(
                                future: _dbService.getTableBookingStatus(
                                    DateTime(_currentDate.year,
                                        _currentDate.month, _currentDate.day),
                                    selectedTime,
                                    snapshot.data[index]['table']['id']),
                                builder: (context, snapshotTime) {
                                  if (!snapshotTime.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: snapshotTime.data['isBooked']
                                          ? Container(
                                              color: Colors.transparent,
                                              child: CustomPaint(
                                                painter: TableRectanglePaint(),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                        left: 10,
                                                        top: 5,
                                                        child: Text(
                                                          'Table ${index < 9 ? '0${index + 1}' : index + 1}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        )),
                                                    Positioned(
                                                        left: 35,
                                                        top: 35,
                                                        child: Text(
                                                          'CLOSED',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                // Make select table
                                                setState(() {
                                                  selectedTable =
                                                      snapshot.data[index]
                                                          ['table']['id'];
                                                });
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                child: CustomPaint(
                                                  painter: selectedTable ==
                                                          snapshot.data[index]
                                                              ['table']['id']
                                                      ? TableRectanglePaint(
                                                          selectedTable:
                                                              selectedTable)
                                                      : TableRectanglePaint(),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                          left: 10,
                                                          top: 5,
                                                          child: Text(
                                                            snapshot.data[index]
                                                                ['table']['id'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                      Positioned(
                                                          left: 35,
                                                          top: 35,
                                                          child: Text(
                                                            'OPEN',
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .greenAccent),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                    );
                                  }
                                });
                          }),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            ElevatedButton(
              onPressed: () {
                _reservationProvider.saveReservationInformation(_currentDate,
                    selectedTable, selectedTime, true, _auth.currentUser.uid);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CheckoutMenuPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text('Submit'),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xff2A2E37),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableRectanglePaint extends CustomPainter {
  String selectedTable;

  TableRectanglePaint({this.selectedTable});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff393F4B);
    Paint paintWithST = Paint()..color = Colors.lightBlue[400];

    final a = Offset(0, 0);
    final b = Offset(size.width, size.height);
    final rect = Rect.fromPoints(a, b);

    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(20)),
        selectedTable != null ? paintWithST : paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
