import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/provider.dart';
import 'package:final_year_project/screens/Reservation/booking_successful_page.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalCheckoutPage extends StatefulWidget {
  const TotalCheckoutPage({Key key}) : super(key: key);

  @override
  _TotalCheckoutPageState createState() => _TotalCheckoutPageState();
}

class _TotalCheckoutPageState extends State<TotalCheckoutPage> {

  List redeemedVoucher = ['Select Voucher'];
  String voucherPicked;
  final _dbService = DatabaseService();
  //adding comment to the restaurant
  String comment = '';

  @override
  void initState() {
    super.initState();
    getVoucher();
  }

  void getVoucher() {
    _dbService.getVoucher().then((value) {
      value.forEach((item) {
        setState(() {
          redeemedVoucher.add(item['voucherName']);
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final _menuProvider = Provider.of<AddPreOrderMenu>(context);
    final _reservationProvider = Provider.of<ReservationInformation>(context);
    final user = Provider.of<Member>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.blueAccent[400],
            size: 18.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Check Out Cart',
          style: TextStyle(
            color: Colors.blueAccent[400],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          'Reservation Details: ',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 60.0, top: 10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Customer : ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(user.username ?? 'Undefined',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Table ID : ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(_reservationProvider.selectedTable,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Booking Date : ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                      _reservationProvider.currentDate
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Time : ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                      _reservationProvider.selectedTime < 12
                                          ? '${_reservationProvider.selectedTime.toString()} a.m.'
                                          : '${_reservationProvider.selectedTime.toString()} p.m.',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Text(
                          'Order Details: ',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                        child: Card(
                          elevation: 1.0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child:
                                  ListView.builder(
                                      itemCount: _menuProvider.selectedMenu.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 5.0, left: 20.0,right: 10.0,),
                                          child: Row(
                                                    children: [
                                                      Text(
                                                        '-- ${_menuProvider.selectedMenu[index]['name']}',
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text('RM ${_menuProvider.selectedMenu[index]['price']}',
                                                          style: TextStyle(
                                                            fontSize: 18.0,
                                                          )),
                                                      IconButton(icon: Icon(Icons.delete_outline, color: Colors.red,),
                                                          onPressed: () {
                                                           setState(() {
                                                             _menuProvider.removeItem(_menuProvider.selectedMenu[index]['name'], _menuProvider.selectedMenu[index]['price']);
                                                           });
                                                      })
                                                    ],
                                            ),
                                        );
                                      }),
                            ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Comment:', style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Any requirements to tell our staff to do it for you?',
                              border: InputBorder.none,
                              ),

                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              maxLines: 5,
                              onChanged: (value) {
                                setState(() {
                                  comment = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(color: Colors.blueAccent, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.local_offer_outlined),
                    SizedBox(width: 10.0),
                    Icon(Icons.arrow_forward_ios_outlined, size: 15.0,),
                    Spacer(),
                    DropdownButton(
                      hint: Text('Promo voucher'),
                      icon: Icon(Icons.arrow_drop_up),
                      items: redeemedVoucher.map((item) {
                        return DropdownMenuItem(child: Text(item), value: item,);
                      }).toList(),
                      value: voucherPicked,
                      onChanged: (value) {
                        if ( value == 'Select Voucher') {
                          setState(() {
                            voucherPicked = value;
                          });
                        } else {
                          setState(() {
                            _menuProvider.useVoucher(value);
                            voucherPicked = value;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(color: Colors.blueAccent, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 30.0,
                ),
                child: Row(
                  children: [
                    Text(
                      'Total Order: ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          letterSpacing: 1.5),
                    ),
                    voucherPicked == 'Select Voucher' ? Text(
                      'RM ${_menuProvider.totalAmount.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22.0,
                          letterSpacing: 1.5),
                    ) : voucherPicked == null ? Text(
                      'RM ${_menuProvider.totalAmount.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22.0,
                          letterSpacing: 1.5),
                    ) : Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RM ${_menuProvider.amountAfterDiscount.toString()}',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 19.0,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            'Price after discount',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.red,
                                fontSize: 10.0,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        //Submit orderReservation and reservation detail into database
                        final result = await _dbService.addOrderDetail(_reservationProvider.currentDate, _reservationProvider.selectedTable, _reservationProvider.selectedTime, true, _reservationProvider.customerId, user.username, _menuProvider.selectedMenu, _menuProvider.amountAfterDiscount, comment);
                        Member member = await _dbService.getCurrentUserInfo();
                        double point = double.parse(member.loyaltyPoint) + _menuProvider.amountAfterDiscount ~/ 10;

                        if (result) {
                          if (voucherPicked != null && voucherPicked != 'Select Voucher') {
                            _dbService.useVoucher(voucherPicked);
                          }
                        }
                        _menuProvider.onSubmit();
                        _dbService.updateMemberPropertiesinDatabase('loyaltyPoint', '$point');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSuccessPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Confirm'),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent[700],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
