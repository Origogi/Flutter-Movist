import 'package:flutter/material.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/pages/movie_detail_page.dart';
import 'package:flutter_list/util/util.dart';
import 'package:flutter_list/widgets/rating_information.dart';

class HorizontalMovieList extends StatelessWidget {
  final List<Movie> movies;
  final String name;

  HorizontalMovieList({this.movies, this.name});

  @override
  Widget build(BuildContext context) {
    double _imageHeight = 180;


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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                Movie movie = movies[index];
                return MovieDetailsPage(
                    movie: movie, heroID: HeroID.make(movie.id, name));
              }));
            },
            child: Container(
              width: _imageHeight * 0.8,
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: HeroID.make(movies[index].id, name),
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            child: FadeInImage(
                              image: NetworkImage(movies[index].posterUrl),
                              fit: BoxFit.cover,
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                            ))),
                  ),
                  Text(movies[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body1)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VerticalMovieList extends StatelessWidget {
  final List<Movie> movies;
  final String name;

  VerticalMovieList(this.movies, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  Movie movie = movies[index];
                  return MovieDetailsPage(
                      movie: movie, heroID: HeroID.make(movie.id, name));
                }));
              },
              child: Container(
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:60.0),
                      child: Container(
                        width: double.infinity,
                        // height: 110,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).accentColor,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 125.0, top: 10.0, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                movies[index].title,
                                style: Theme.of(context).textTheme.title,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                    child: RatingInformation(movies[index], false),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '개봉 날짜 : ',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  Text(
                                    movies[index].release_date,
                                    style: Theme.of(context).textTheme.body1,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 8,
                      child: Hero(
                        tag: HeroID.make(movies[index].id, name),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 4),
                                    blurRadius: 6)
                              ]),
                          width: 100,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              image: NetworkImage(movies[index].posterUrl),
                              fit: BoxFit.cover,
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
