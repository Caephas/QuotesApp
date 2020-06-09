import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  Widget body(String svg, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          svg,
          width: 25,
          color: Colors.black,
        ),
        SizedBox(width: 20,),
        Container(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 24),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.pop(context);},
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){Navigator.pop(context);},
                  child: Container(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      'assets/images/cancel.svg',
                      width: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Contact Us',
                    style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 24),
                  ),
                ),
                SizedBox(height: 30,),
                body('assets/images/twitter.svg', '@hnginternship'),
                SizedBox(height: 25,),
                body('assets/images/mail.svg', 'hello@hng.tech'),
                SizedBox(height: 25,),
                body('assets/images/web.svg', 'hng.tech'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}