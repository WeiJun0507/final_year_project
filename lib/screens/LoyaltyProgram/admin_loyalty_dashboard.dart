import 'package:final_year_project/screens/LoyaltyProgram/edit_loyalty_promotion.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'add_loyalty_promotion.dart';

class AdminLoyaltyDashboard extends StatefulWidget {
  AdminLoyaltyDashboard({Key key}) : super(key: key);

  @override
  _AdminLoyaltyDashboardState createState() => _AdminLoyaltyDashboardState();
}

class _AdminLoyaltyDashboardState extends State<AdminLoyaltyDashboard> {
  String title;
  String description;
  double discountPercentage;

  final _dbService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  _onSubmit() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      try {
        final result = await _dbService.loyaltyVoucherForNewUser(title, description, DateTime.now().add(Duration(days: 7)), discountPercentage);

        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Edit Successful',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red[300],
          ));
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Edit Failed',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red[700],
        ));
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.redAccent[400],
              size: 16.0,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                  ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:20.0, left: 40.0, right: 40.0, bottom: 10.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Text('Set New User Giveaway Voucher', style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    SizedBox(height: 10.0,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Title',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          title = value;
                                        });
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          title = value;
                                        });
                                      },
                                      validator: (value) => value.isEmpty ? 'Title cannot be empty' : null,
                                    ),
                                    SizedBox(height: 10.0,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Description',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          description = value;
                                        });
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          description = value;
                                        });
                                      },
                                      validator: (value) => value.isEmpty ? 'Description cannot be empty' : null,
                                    ),
                                    SizedBox(height: 10.0,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Discount Percentage',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      onChanged: (value) {
                                        setState(() {
                                          discountPercentage = double.parse(value);
                                        });
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          discountPercentage = double.parse(value);
                                        });
                                      },
                                      validator: (value) => value.isEmpty ? 'Discount Percentage cannot be empty' : null
                                    ),
                                    SizedBox(height: 15.0,),
                                    ElevatedButton(
                                      onPressed: () {
                                        _onSubmit();
                                      },
                                      child: Text('SUBMIT'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Loyalty Promotion Management",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent[700],
                  shadows: [
                    Shadow(color: Colors.grey[400], blurRadius: 10.0),
                  ]),
            ),
            //display LoyaltyPromotion here by fetching the promotion from firebase
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: StreamBuilder(
                    stream: _dbService.getLoyaltyProgramPromotion(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DateTime expiredDate = snapshot
                                  .data.docs[index]['expiredDate']
                                  .toDate();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data.docs[index]
                                                  ['title'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Text(snapshot.data.docs[index]
                                                ['description']),
                                            SizedBox(height: 15.0),
                                            Row(
                                              children: [
                                                Text(
                                                  'Discount Percentage: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(snapshot
                                                    .data
                                                    .docs[index]
                                                        ['discountPercentage']
                                                    .toString()),
                                              ],
                                            ),
                                            SizedBox(height: 5.0),
                                            Row(
                                              children: [
                                                Text(
                                                  'Expired Date: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(
                                                    '${expiredDate.year}-${expiredDate.month}.${expiredDate.day}'),
                                              ],
                                            ),
                                            SizedBox(height: 5.0),
                                            Row(
                                              children: [
                                                Text(
                                                  'Require Loyalty Point: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Text(snapshot.data
                                                    .docs[index]['loyaltyPoint']
                                                    .toString()),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                //EditPage, Delete function
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.edit_outlined,
                                                      color: Colors
                                                          .blueAccent[700],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditLoyaltyPromotion(
                                                                  title: snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      [
                                                                      'title'])));
                                                    }),
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.delete_outlined,
                                                      color:
                                                          Colors.redAccent[700],
                                                    ),
                                                    onPressed: () {
                                                      _dbService
                                                          .deleteLoyaltyProgramPromotion(
                                                              snapshot.data
                                                                          .docs[
                                                                      index]
                                                                  ['title']);
                                                    }),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            });
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddLoyaltyPromotion()));
              },
              child: Text('Add Promotion'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
            ),
          ],
        ),
      ),
    );
  }
}
