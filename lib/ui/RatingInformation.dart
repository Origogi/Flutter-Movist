import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/network/data.dart';


class RatingInformation extends StatelessWidget {

  final Movie movie;
  RatingInformation(this.movie);

  Widget _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];

    for (var i = 1; i<=5;i++ ) {
      var color = i <= movie.vote_average/2.0 ? theme.accentColor : Colors.black12;

      var star = Icon(
        Icons.star,
        color: color,
      );
      
      stars.add(star);
    }
    return Row(children: stars,);


  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption;

    var numberricRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(movie.vote_average.toString(),
        style : textTheme.title.copyWith(
          fontWeight :FontWeight.w400,
          color :theme.accentColor
        )),
        SizedBox(height: 4.0,),
        Text(
          'Ratings',
          style : ratingCaptionStyle
        )
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildRatingBar(theme),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text(
            'Grade now',
            style :ratingCaptionStyle
          ),
        )
      ],
    );

    return Row(children: <Widget>[
      numberricRating,
      SizedBox(width: 16.0,),
      starRating
    ],);
  }

}