import 'package:final_year_project/model/sliderDetail.dart';
import 'package:flutter/material.dart';

class SliderDetailPage extends StatefulWidget {
  final SliderDetail item;

  const SliderDetailPage({Key key, this.item}) : super(key: key);

  @override
  _SliderDetailPageState createState() => _SliderDetailPageState();
}

class _SliderDetailPageState extends State<SliderDetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.item.title, style: TextStyle(
          color: Colors.lightBlueAccent,
          fontSize: 22.0,
        )),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_outlined, color: Colors.lightBlue),
          onTap: () {Navigator.pop(context);},
        ),
      ),

      body: Column(
        children: [
          Image.asset(widget.item.image, height: 350, fit: BoxFit.fill),
          SizedBox(height:10.0),
          Text(widget.item.title, style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),),
          SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(widget.item.description, style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300
            ),),
          )
        ],
      ),
      
    );
  }
}
