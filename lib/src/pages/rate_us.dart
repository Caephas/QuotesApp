import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quotesapp/styles/colors.dart';
import 'package:rating_bar/rating_bar.dart';

class RateUs extends StatelessWidget {
  static const String routeName = "/rate";

  showQuotesDialog(BuildContext context) {
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
            height: 150,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      width: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Rate Us',
                    style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 30),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: RatingBar(
                    onRatingChanged: (rating){},
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    filledColor: blue,
                    emptyColor: Colors.grey.shade400,
                    halfFilledColor: blueOpa, 
                    size: 48,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return showQuotesDialog(context);
  }
}