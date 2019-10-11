import 'package:flutter/material.dart';
import 'package:flutter_list/model/FavoriteModel.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/ui/ArcBannerImage.dart';
import 'package:flutter_list/ui/Poster.dart';
import 'package:flutter_list/ui/RatingInformation.dart';
import 'package:flutter_list/ui/Stroyline.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatelessWidget {
  Movie movie;
  MovieDetailsPage(this.movie) {
    print(movie.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                        onPressed: () => {Navigator.pop(context)},
                      ),
                      Consumer<FavoriteModel>(builder: (context, model, child) {
                        return  IconButton(
                        icon: Icon(
                          model.containMovieID(movie.id) ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          if (model.containMovieID(movie.id)) {
                            model.removeMovieID(movie.id);
                          }
                          else {
                            model.addMovieID(movie.id);
                          }
                        },
                      );
                      }),
                     
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: StoryLine(movie.overview),
            ),
          ],
        ),
      ),
    );
  }
}

  


class MovieDetailHeader extends StatelessWidget {
  Movie movie;

  MovieDetailHeader(this.movie);

  List<Widget> _buildCategoryChips(List<String> genres, TextTheme textTheme) {
    return genres.map((genre) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(genre),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
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
          style: textTheme.title,
        ),
        SizedBox(
          height: 8.0,
        ),
        RatingInformation(movie),
        SizedBox(height: 12.0),
        FutureBuilder(
            future: MovieDBApi.getGenres(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                GenresApiResponse apiResponse = snapshot.data;

                print(movie.genre_ids.toString());

                List<String> genres = movie.genre_ids.map((id) {
                  return apiResponse.genresMap[id];
                }).toList();

                print(genres.toString());
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildCategoryChips(genres, textTheme),
                  ),
                );
              } else {
                return Container();
              }
            }),
      ],
    );

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 140.0),
          child: ArcBannerImage(movie.backDropUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Poster(posterUrl: movie.posterUrl, height: 180.0),
              SizedBox(
                width: 16,
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
}
