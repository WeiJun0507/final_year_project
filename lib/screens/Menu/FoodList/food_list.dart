
import 'package:final_year_project/customWidget/customFoodListCard.dart';
import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Menu/food_detail.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addFoodMenu.dart';

class FoodListDetail extends StatefulWidget {
  final category;
  final bool admin;
  const FoodListDetail({Key key, this.category, this.admin}) : super(key: key);

  @override
  _FoodListDetailState createState() => _FoodListDetailState();
}

class _FoodListDetailState extends State<FoodListDetail> {
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
            color: Colors.green,
            size: 16.0,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        actions: [
          widget.admin ? IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.green,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFoodMenu(category : widget.category)));
              }) : Text(''),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomFoodListCard(
                        admin: widget.admin,
                        name: snapshot.data[index]['foodList']['name'],
                        image: snapshot.data[index]['foodList']['picture'],
                        description: snapshot.data[index]['foodList']['description'],
                        price: snapshot.data[index]['foodList']['price'],
                        category: snapshot.data[index]['foodList']['category'],
                        onCallback: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetail(object: snapshot.data[index]['foodList'])));
                        },
                      ),
                    );
                  }),
                );
              }
              return Text('No data found');
            },
          ),
        ),
      ),
    );
  }
}
