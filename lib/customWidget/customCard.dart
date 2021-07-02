import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/screens/Menu/editMenuCategory.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCategoryCard extends StatelessWidget {

  final VoidCallback onCallback;
  final String image;
  final String title;
  final String description;
  final bool admin;

  CustomCategoryCard(
      {
      this.onCallback,
      this.image,
      this.description,
      this.title,
      this.admin});

  final DatabaseService _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: InkWell(
            onTap: () {
              onCallback();
            },
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex:4,
                      child: image !=null ? Ink.image(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ) : Container(
                        color: Colors.grey[300],
                      ) ,),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w800,
                          ),),
                          SizedBox(height: 17.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(description, style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[800],
                              letterSpacing: 0.5,
                            ),),
                          ),
                          Spacer(),
                          admin ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Icon(Icons.edit_outlined),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditCategory(category: title,)));
                                },
                              ),
                              SizedBox(width:20.0),
                              InkWell(
                                child: Icon(Icons.delete_outlined, color: Colors.red,),
                                onTap: () {
                                  _dbService.deleteMenuCategory(title);
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
