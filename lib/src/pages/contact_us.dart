import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUs extends StatelessWidget {

  Widget body(String svg, String text, BuildContext context) {
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

  showContactDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
              )
          ),
          contentPadding: EdgeInsets.all(0.0),
          content: Container(
            height: MediaQuery.of(context).size.height / (MediaQuery.of(context).size.height/250),
            width: MediaQuery.of(context).size.width,
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
                body('assets/images/twitter.svg', '@hnginternship', context),
                SizedBox(height: 20,),
                body('assets/images/mail.svg', 'hello@hng.tech', context),
                SizedBox(height: 20,),
                body('assets/images/web.svg', 'hng.tech', context),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}