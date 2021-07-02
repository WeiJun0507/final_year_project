import 'package:flutter/material.dart';
class ProfileOption extends StatelessWidget {

  final String title;
  final IconData customIcon;
  final VoidCallback onCalled;

  const ProfileOption({Key key, this.title, this.customIcon, this.onCalled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          side: BorderSide(
            color: Colors.yellow[900],
            width: 2.5,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              )
          )
      ),
      onPressed: () {
        onCalled();
      },
      child: Container(
        height: 52.5,
        width: MediaQuery.of(context).size.width * 0.80,

        child: ListTile(
          leading: Icon(customIcon, color: Colors.black54),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
