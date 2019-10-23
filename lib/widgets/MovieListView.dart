import 'package:flutter/material.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/pages/movie_detail_page.dart';


class MovieListView extends StatelessWidget {
  List<Movie> movies;

  MovieListView(this.movies);

  double _imageHeight = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: _imageHeight * 0.7,
                  height: _imageHeight,
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
                      child: Image.network(
                        movies[index].posterUrl,
                        fit: BoxFit.cover,
                      )),
                ),
                Text(
                  movies[index].title.length <= 4 ? movies[index].title : movies[index].title.substring(0,3) + "...",
                  style : Theme.of(context).textTheme.body1
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
