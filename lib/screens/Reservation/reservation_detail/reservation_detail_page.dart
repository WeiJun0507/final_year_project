import 'package:flutter/material.dart';

class ReservationDetailPage extends StatefulWidget {
  final String tableId;
  final DateTime bookedDate;
  final double totalPrice;
  final List selectedFood;
  final String comment;
  const ReservationDetailPage({Key key, this.tableId, this.bookedDate, this.totalPrice, this.selectedFood, this.comment}) : super(key: key);

  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {


  @override
  Widget build(BuildContext context) {
    print(widget.tableId);
    print(widget.bookedDate);
    print(widget.selectedFood);
    print(widget.comment);
    print(widget.totalPrice.toString());
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(widget.tableId, style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),),
                    Divider(color: Colors.black),
                    SizedBox(height: 6.0,),

                    Text('Booked Date: ', style: TextStyle(
                      fontSize: 18.0,
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 3.0,),
                      child: Text(widget.bookedDate.toString().substring(0, 10), style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
            Divider(color: Colors.black,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Menu Ordered:',style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: widget.selectedFood.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(widget.selectedFood[index]['name']),
                          Text(widget.selectedFood[index]['price']),
                        ],
                      ),
                    );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Comment:', style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 10.0),
              child: Text(widget.comment, style: TextStyle(
                fontSize: 14.0,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
