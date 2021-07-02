import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double customSize;
  final Color pColor;
  final VoidCallback navigation;
  const HomePageButton({
    Key key,
    this.imageUrl,
    this.title,
    this.customSize,
    this.pColor,
    this.navigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: pColor,
        padding: EdgeInsets.all(0.0),
        elevation: 6.0,
      ),
      onPressed: () {
        navigation();
        },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        height: MediaQuery.of(context).size.height * 0.23,

        decoration: BoxDecoration(
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: pColor,
                offset: Offset(1.0, 1.0),
                blurRadius: 10,
              )
            ]
        ),
        child: Column(
          children: [
            Image.asset(imageUrl, height: 125, fit:BoxFit.fill),
            SizedBox(height: 10),
            Text(title, style: TextStyle(
              fontSize: customSize,
              color: pColor,
              fontWeight: FontWeight.w700
            ),)
          ],
        )
      ),
    );
  }
}
