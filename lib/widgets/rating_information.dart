import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/model/models.dart';

class RatingInformation extends StatelessWidget {
  final Movie movie;
  final bool alingCenter;
  RatingInformation(this.movie, this.alingCenter);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var numberricRating =
        Text(movie.voteAverage.toString(), style: textTheme.body1);

    var starRating = Icon(
      Icons.star,
      color: theme.accentColor,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          alingCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        numberricRating,
        SizedBox(
          width: 10.0,
        ),
        starRating,
      ],
    );
  }
}
