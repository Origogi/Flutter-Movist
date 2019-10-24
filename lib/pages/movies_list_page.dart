import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_list/network/data.dart';

class MoviesListPage extends StatelessWidget {
  final List<Movie> movies;
  final String title;
  
  MoviesListPage({this.movies, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
              Navigator.pop(context);
          },
        ),
      ),
      body: Container(),
    );
  }

}