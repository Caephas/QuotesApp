import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quotesapp/styles/colors.dart';
import 'package:rating_bar/rating_bar.dart';

class RateUs extends StatefulWidget {
  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
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
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
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
        ),
      ),
    );
  }
}