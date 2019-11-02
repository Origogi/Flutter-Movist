import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/state/states.dart';
import 'package:flutter_list/widgets/arc_banner_image.dart';
import 'package:flutter_list/widgets/poster.dart';
import 'package:flutter_list/widgets/rating_information.dart';

import 'package:flutter_list/widgets/story_line.dart';
import 'package:provider/provider.dart';

import 'movies_list_page.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  MovieDetailsPage(this.movie) {
    print(movie.title);
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
                          state.containMovie(movie.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          var content;
                          if (state.containMovie(movie.id)) {
                            state.removeMovie(movie.id);
                            content = Text("'나의 즐겨찾기'에서 삭제 되었습니다.");
                          } else {
                            state.addMovie(movie.id, movie);
                            content = Text("'나의 즐겨찾기'에 추가 되었습니다.");
                          }

                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: content,
                            action: SnackBarAction(
                              label: '확인',
                              onPressed: (){},
                            ),
                          ));
                        },
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: StoryLine(movie),
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
      Map<int, String> genresMap, TextTheme textTheme) {
    return genresIDs.map((id) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesListPage(
                    title: '장르 : ${genresMap[id]}',
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
            label: Text(genresMap[id]),
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
        Text(
          movie.title,
          style: (textTheme.title),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 5.0,
        ),
        RatingInformation(movie),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: <Widget>[Text('개봉 날짜 : '), Text(movie.release_date)],
        ),
        SizedBox(height: 5.0),
        FutureBuilder(
            future: MovieDBApi.getGenres(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<int, String> genresMap = snapshot.data;
                print(movie.genre_ids.toString());

                List<int> movieRelatedGenres = [];

                if (movie.genre_ids != null) {
                  movieRelatedGenres = movie.genre_ids;
                } else {
                  movieRelatedGenres =
                      movie.genres.map((genre) => genre.id).toList();
                }

                return SizedBox(
                  height: 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildCategoryChips(
                          context, movieRelatedGenres, genresMap, textTheme),
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
              Poster(
                imageUrl: movie.posterUrl,
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
