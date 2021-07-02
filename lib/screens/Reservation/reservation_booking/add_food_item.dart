import 'package:final_year_project/customWidget/customAddItemCard.dart';
import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Menu/food_detail.dart';
import 'package:final_year_project/screens/Reservation/total_checkout_page.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFoodItem extends StatefulWidget {
  final category;
  const AddFoodItem({Key key, this.category}) : super(key: key);

  @override
  _AddFoodItemState createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {

  final _dbService = DatabaseService();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.blueAccent,
            size: 16.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      ),
      body: Container(
        child: FutureBuilder(
          future: _dbService.getFoodDetails(widget.category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              var _list = snapshot.data.toList();

              return Column(
                children: List.generate(_list.length, (index) {
                  return CustomAddItemCard(
                      name: snapshot.data[index]['foodList']['name'],
                      image: snapshot.data[index]['foodList']['picture'],
                      description: snapshot.data[index]['foodList']['description'],
                      price: snapshot.data[index]['foodList']['price'],
                      category: snapshot.data[index]['foodList']['category'],
                    );
                }),
              );
            }
            return Text('No data found');
          },
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
          icon: Icon(Icons.arrow_forward_outlined),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => TotalCheckoutPage()));
          },
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
