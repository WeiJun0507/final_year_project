import 'package:final_year_project/customWidget/customCard.dart';
import 'package:final_year_project/screens/Menu/FoodList/food_list.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';

import 'addMenuCategory.dart';

class MenuDashboard extends StatefulWidget {
  final bool admin;

  const MenuDashboard(this.admin);

  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {
  final _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.07,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.green,
                size: 16.0,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
           widget.admin ?
            IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCategory()));
                }) : Text('')
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a category you like:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
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
                              admin: widget.admin,
                              image: snapshot.data[index]['picture'],
                              title: snapshot.data[index]['title'],
                              description: snapshot.data[index]['description'],
                              onCallback: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FoodListDetail(category: snapshot.data[index]['category'], admin: widget.admin)));
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
        ));
  }
}
