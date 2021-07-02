import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Menu/FoodList/editFoodMenu.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFoodListCard extends StatelessWidget {
  final VoidCallback onCallback;
  final String image;
  final String name;
  final String description;
  final String price;
  final String category;
  final bool admin;

  CustomFoodListCard(
      {
      this.onCallback,
      this.image,
      this.description,
      this.name,
      this.price,
      this.category,
      this.admin});

  final DatabaseService _dbService = DatabaseService();


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: InkWell(
          onTap: () {
            onCallback();
          },
          child: Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: image != null
                      ? Ink.image(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[300],
                        ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            description.split(",")[0],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[800],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 7.0),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            'RM $price',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                              letterSpacing: 0.5,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        Spacer(),
                        admin ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Icon(Icons.edit_outlined),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditFoodMenu(name: name, category: category)));
                              },
                            ),
                            SizedBox(width: 20.0),
                            InkWell(
                              child: Icon(
                                Icons.delete_outlined,
                                color: Colors.red,
                              ),
                              onTap: () {
                                _dbService.deleteFoodMenu(category, name);
                              },
                            )
                          ],
                        ) : Text(''),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
