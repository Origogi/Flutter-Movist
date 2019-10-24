
import 'package:flutter/material.dart';

class MovieSearchPage extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => '';

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
          onPressed: () {}),
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


    return Container(
      color: themeData.backgroundColor,
      child: Center(
        child: Text('Input words!!', style: themeData.textTheme.title),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      color: themeData.backgroundColor,
      child: Center(
        child: Text('Sugestion', style: themeData.textTheme.title),
      ),
    );
  }
}
