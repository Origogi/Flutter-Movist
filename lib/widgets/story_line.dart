import 'package:flutter/material.dart';
import 'package:flutter_list/network/data.dart';

class StoryLine extends StatelessWidget {
  final Movie movie;

  StoryLine(this.movie);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          
         
          Text(
            '줄거리',
            style: textTheme.body1,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            movie.overview.isNotEmpty ? movie.overview : "상세 정보 없음",
            style: textTheme.body2,
          )
        ],
      ),
    );
  }
}
