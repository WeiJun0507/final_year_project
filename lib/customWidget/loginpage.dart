import 'package:flutter/material.dart';

class HeaderLayout extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double height;
  final double top;
  final double left;
  final double size;

  const HeaderLayout(
      {Key key,
      this.title,
      this.imageUrl,
      this.height,
      this.top,
      this.left,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(imageUrl),
        fit: BoxFit.fill,
      )),
      child: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * top,
            left: MediaQuery.of(context).size.width * left,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}
