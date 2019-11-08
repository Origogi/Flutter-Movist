import 'package:flutter/material.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/widgets/movie_list.dart';

class MovieSearchPage extends SearchDelegate<String> {
  var result;

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return themeData;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return [
      IconButton(
          icon: Icon(Icons.clear, color: themeData.iconTheme.color),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: themeData.iconTheme.color,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    if (result != null && result.isNotEmpty) {
      return VerticalMovieList(result, 'search');
    }

    return Container(
        child: FutureBuilder(
      future: MovieDBApi.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List movies = snapshot.data;

          result = movies;

          if (movies == null || movies.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.block,
                  size: 55,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("'$query'를 찾을 수 없습니다.", style: themeData.textTheme.body1)
              ],
            ));
          }
          return VerticalMovieList(snapshot.data, 'search');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    result = null;
    
    return Container(
      color: themeData.backgroundColor,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            size: 55,
          ),
          SizedBox(
            height: 10,
          ),
          Text('영화 이름을 입력해 주세요.', style: themeData.textTheme.body1)
        ],
      )),
    );
  }
}
