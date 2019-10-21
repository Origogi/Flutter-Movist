import 'package:flutter/material.dart';

class StoryLine extends StatelessWidget {
  final String storyLine;

  StoryLine(this.storyLine);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
        print(storyLine);

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
          Text(
            '줄거리',
            style: textTheme.title,
          ),
          SizedBox(height: 8,),

          Text(
            !storyLine.isEmpty? storyLine : "상세 정보 없음",
            style: textTheme.body2,
          )
        ],
      ),
    );
  }
  
}