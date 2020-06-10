import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const CardButton({Key key, this.icon, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(icon, color: Colors.grey,),
          SizedBox(
            height: 3,
          ),
          Text(text)
        ],
      ),
      onTap: (){},
    );
  }
}