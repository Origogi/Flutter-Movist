import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/network/data.dart';

class RatingInformation extends StatelessWidget {
  final Movie movie;
  RatingInformation(this.movie);


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var numberricRating = Text(movie.vote_average.toString(),
        style: textTheme.headline);
            

    var starRating = Icon(
      Icons.star
      ,color: theme.accentColor,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
