import 'package:flutter/material.dart';
import 'package:flutter_list/ui/Poster.dart';

import 'MovieDetailPage.dart';
import 'network/data.dart';

class MovieListView extends StatelessWidget {
  List<Movie> movies;

  MovieListView(this.movies);

  int _imageHeight = 180;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(index);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(movies[index])));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 4),
                        blurRadius: 6)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Poster(
                  posterUrl: movies[index].posterUrl,
                  height: 250,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
