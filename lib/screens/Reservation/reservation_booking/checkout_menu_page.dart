import 'package:final_year_project/customWidget/customCard.dart';
import 'package:final_year_project/provider.dart';
import 'package:final_year_project/screens/Reservation/reservation_booking/add_food_item.dart';
import 'package:final_year_project/screens/Reservation/reservation_booking/reservation_booking_dashboard.dart';
import 'package:final_year_project/screens/Reservation/total_checkout_page.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutMenuPage extends StatefulWidget {

  const CheckoutMenuPage(
      {Key key})
      : super(key: key);

  @override
  _CheckoutMenuPageState createState() => _CheckoutMenuPageState();
}

class _CheckoutMenuPageState extends State<CheckoutMenuPage> {

  final _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final _menuProvider = Provider.of<AddPreOrderMenu>(context);

    return WillPopScope(
      onWillPop: () async {
        _menuProvider.clearItem();
        Navigator.pop(context);
        return true;
        },
      child: Scaffold(
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
                  _menuProvider.clearItem();
                  Navigator.pop(context);
                },
              ),
            ),
            title: Text(
              'Pre Order Menu',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: _dbService.getMenuCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          var _list = snapshot.data.toList();
                          return Column(
                            children: List.generate(_list.length, (index) {
                              return CustomCategoryCard(
                                admin: false,
                                image: snapshot.data[index]['picture'],
                                title: snapshot.data[index]['title'],
                                description: snapshot.data[index]['description'],
                                onCallback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddFoodItem(
                                              category: snapshot.data[index]
                                                  ['category'])));
                                },
                              );
                            }),
                          );
                        }
                        return Text('No data found');
                      })
                ],
              ),
            ),
          ),
        floatingActionButton: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
              color: Colors.blueAccent[400],
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width / 2))
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_forward_outlined,size: 25.0,),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TotalCheckoutPage()));
            },
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
