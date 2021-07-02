import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios_outlined,
              color: Colors.green[700],
            ),
        onTap: () {
              Navigator.pop(context);
        },),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset('assets/image/Food-Logo.png'),
                ),
              ),
              SizedBox(height: 15.0),
              Text('EasyBook Reservation', style: TextStyle(
                fontSize: 25.0,
                fontWeight:  FontWeight.bold,
              ),),
              SizedBox(height: 8.0),
              Text('Version 1.0.0', style: TextStyle(
                fontSize: 20.0,
                fontWeight:  FontWeight.w400,
              ),),
              SizedBox(height: 15.0),
              Divider(height: 15, thickness: 1.5),
              Text('Copyright \u00a9 2021 EasyBook', style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
