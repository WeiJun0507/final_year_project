import 'package:flutter/material.dart';

class ReservationAdminDetailPage extends StatefulWidget {
  final String customerName;
  final String comment;
  final DateTime bookedDate;
  final List selectedItem;
  final String tableId;
  final double totalPrice;

  const ReservationAdminDetailPage(
      {Key key, this.customerName, this.bookedDate, this.selectedItem, this.tableId, this.comment, this.totalPrice})
      : super(key: key);

  @override
  _ReservationAdminDetailPageState createState() =>
      _ReservationAdminDetailPageState();
}

class _ReservationAdminDetailPageState
    extends State<ReservationAdminDetailPage> {
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
        title: Text('${widget.customerName} : ${widget.tableId}', style: TextStyle(
          fontSize: 20.0,
          color: Colors.lightBlueAccent,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Column(
              children: [
          Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20.0, bottom: 20.0),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.12,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.28,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 17.0),
                  child: Text(' User :', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 1.2,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.customerName, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    letterSpacing: 1.2,
                  ),),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, bottom: 1.0),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.08,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                ),
                child: Center(child: Text(
                  'Table Booked: ${widget.tableId}', style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 10.0, bottom: 2.0),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.08,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 8.0),
                    child: Text('BookingDate :', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0, top: 5.0),
                    child: Text(widget.bookedDate.toString().substring(0, 16),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),),
                  ),
                ]
                ),
              ),),],
            )
          ],
        ),
      ),
      Divider(color: Colors.white, thickness: 3,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0, bottom: 8.0),
              child: Text('Menu Ordered: ', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.27,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: ListView.builder(
                  itemCount: widget.selectedItem.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.selectedItem[index]['name']} :',
                            style: TextStyle(
                              fontSize: 16.0,
                              letterSpacing: 1.2,
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('RM ${widget
                              .selectedItem[index]['price']}'),
                        ),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  child: Text(
                    'Total: RM ${widget.totalPrice}', textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),)),
            ),

          ],
        ),
      ),
      Divider(color: Colors.white, thickness: 3,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.22,
          width: double.infinity,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comment:', style: TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
              Text(widget.comment, style: TextStyle(
                letterSpacing: 1.1,
                fontSize: 15.0,
                color: Colors.white,
              ),)
            ],
          ),
        ),
      )
      ],
    ),)
    ,
    )
    ,
    );
  }
}
