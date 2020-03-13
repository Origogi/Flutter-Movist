import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/locale/translations.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/pages/movies_list_page.dart';

class CategoryChips extends StatelessWidget {
  final List<int> genresIDs;
  final Map<int, String> genresMap;

  CategoryChips(this.genresIDs, this.genresMap);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildCategoryChips(context, genresIDs, genresMap));
  }

  List<Widget> _buildCategoryChips(
      BuildContext context, List<int> genresIDs, Map<int, String> genresMap) {
    var theme = Theme.of(context).textTheme;

    return genresIDs.map((id) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesListPage(
                    title:
                        '${Translations.of(context).trans(transKeyGenre)} : ${genresMap[id]}',
                    movies: MovieDBApi.getRelatedGenreMovies(id),
                  ),
                ));
          },
          child: Chip(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: kDarkTheme.accentColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            label: Text(genresMap[id]),
            labelStyle: theme.caption,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    }).toList();
  }
}
