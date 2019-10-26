import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/state/states.dart';
import 'package:flutter_list/widgets/ArcBannerImage.dart';
import 'package:flutter_list/widgets/rating_information.dart';

import 'package:flutter_list/widgets/story_line.dart';
import 'package:provider/provider.dart';

import 'movies_list_page.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  MovieDetailsPage(this.movie) {
    print(movie.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              MovieDetailHeader(movie),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Consumer<FavoriteState>(builder: (context, state, child) {
                      return IconButton(
                        icon: Icon(
                          state.containMovieID(movie.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          if (state.containMovieID(movie.id)) {
                            state.removeMovieID(movie.id);
                          } else {
                            state.addMovie(movie.id);
                          }
                        },
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: StoryLine(movie.overview),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MovieDetailHeader extends StatelessWidget {
  final Movie movie;

  MovieDetailHeader(this.movie);

  List<Widget> _buildCategoryChips(BuildContext context, List<int> genresIDs,
      Map<int, String> genres, TextTheme textTheme) {
    return genresIDs.map((id) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesListPage(
                    title: '장르 : ${genres[id]}',
                    movies: MovieDBApi.getRelatedGenreMovies(id),
                  ),
                ));
          },
          child: Chip(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: kDarkTheme.accentColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            label: Text(genres[id]),
            labelStyle: textTheme.caption,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getTitleWidget(textTheme, movie.title),
        SizedBox(
          height: 5.0,
        ),
        RatingInformation(movie),
        SizedBox(height: 5.0),
        FutureBuilder(
            future: MovieDBApi.getGenres(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                GenresApiResponse apiResponse = snapshot.data;

                print(movie.genre_ids.toString());

                Map<int, String> genresMap = {};

                for (int id in movie.genre_ids) {
                  genresMap[id] = apiResponse.genresMap[id];
                }

                return SizedBox(
                  height: 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildCategoryChips(context, movie.genre_ids,
                          apiResponse.genresMap, textTheme),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 70,
                );
              }
            }),
      ],
    );

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 170.0),
          child: ArcBannerImage(movie.backDropUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 12.0,
          right: 12.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: 130,
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
                      movie.posterUrl,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: movieInformation,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getTitleWidget(TextTheme textTheme, String title) {
    return Text(
      title,
      style: (textTheme.title),
      overflow: TextOverflow.ellipsis,
    );
  }
}
