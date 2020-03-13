import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/locale/translations.dart';
import 'package:flutter_list/model/models.dart';

class StoryLine extends StatelessWidget {
  final Movie movie;

  StoryLine(this.movie);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    String overview = movie.overview.isNotEmpty ? movie.overview : "상세 정보 없음";

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ExpandablePanel(
            header: Text(Translations.of(context).trans(transKeySummary), style: textTheme.subhead),
            collapsed: Text(overview,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.body2),
            expanded: Text(overview, softWrap: true, style: textTheme.body2),
            tapHeaderToExpand: true,
            hasIcon: true,
          ),
        ],
      ),
    );
  }
}
