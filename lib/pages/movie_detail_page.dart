import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/locale/translations.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/state/states.dart';
import 'package:flutter_list/util/util.dart';
import 'package:flutter_list/widgets/arc_banner_image.dart';
import 'package:flutter_list/widgets/back_button.dart';
import 'package:flutter_list/widgets/cast_list.dart';
import 'package:flutter_list/widgets/category_chips.dart';
import 'package:flutter_list/widgets/crew_list.dart';
import 'package:flutter_list/widgets/poster.dart';
import 'package:flutter_list/widgets/rating_information.dart';

import 'package:flutter_list/widgets/story_line.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  final String heroID;
  MovieDetailsPage({this.movie, this.heroID});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailsPageState(movie: movie, heroID: heroID);
  }
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final Movie movie;
  final String heroID;

  Future<CreaditResult> creditResultFuture;
  Future<Map<int, String>> genresMapFuture;

  _MovieDetailsPageState({this.movie, this.heroID}) {
    print(movie.title);
  }

  @override
  void initState() {
    super.initState();

    creditResultFuture = MovieDBApi.getCasts(movie.id);
    genresMapFuture = MovieDBApi.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                MovieDetailHeaderWidget(movie: movie, heroID: heroID),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomBackButton(),
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
                              content = Text(
                                Translations.of(context)
                                    .trans(transKeyRemoveFavoriteMessage),
                              );
                            } else {
                              state.addMovie(movie);
                              content = Text(
                                Translations.of(context)
                                    .trans(transKeyAddFavoriteMessage),
                              );
                            }

                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: content,
                              action: SnackBarAction(
                                label: Translations.of(context)
                                    .trans(transKeyConfirm),
                                onPressed: () {},
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
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StoryLine(movie),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          Translations.of(context).trans(transKeyDirector),
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FutureBuilder(
                            future: creditResultFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Crew> crews = snapshot.data.crews;

                                crews = crews
                                    .where((crew) => crew.job == 'Director')
                                    .toList();
                                return CrewList(crews: crews);
                              } else {
                                return Container(
                                    height: 150,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                            }),
                        Text(
                          Translations.of(context).trans(transKeyCasts),
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FutureBuilder(
                            future: creditResultFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CastList(casts: snapshot.data.casts);
                              } else {
                                return Container(
                                    height: 150,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                            })
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailHeaderWidget extends StatefulWidget {
  final Movie movie;
  final String heroID;

  MovieDetailHeaderWidget({this.movie, this.heroID});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailHeaderState(movie: movie, heroID: heroID);
  }
}

class _MovieDetailHeaderState extends State<MovieDetailHeaderWidget> {
  final Movie movie;
  final String heroID;

  Future<Map<int, String>> genresMapFuture;
  _MovieDetailHeaderState({this.movie, this.heroID});

  void initState() {
    super.initState();

    genresMapFuture = MovieDBApi.getGenres();
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
        RatingInformation(movie, false),
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: <Widget>[
            Text(
              '${Translations.of(context).trans(transKeyOpenDate)} : ',
              style: textTheme.body2,
            ),
            Text(movie.releaseDate, style: textTheme.body2)
          ],
        ),
        SizedBox(height: 5.0),
        FutureBuilder(
            future: genresMapFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<int, String> genresMap = snapshot.data;
                print(movie.genreIDs.toString());

                List<int> movieRelatedGenres = [];

                if (movie.genreIDs != null) {
                  movieRelatedGenres = movie.genreIDs;
                } else {
                  movieRelatedGenres =
                      movie.genres.map((genre) => genre.id).toList();
                }

                return SizedBox(
                  height: 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CategoryChips(movieRelatedGenres, genresMap),
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
          child: Hero(
              tag: HeroID.make(movie.id, 'backdrop'),
              child: ArcBannerImage(movie.backDropUrl)),
        ),
        Positioned(
          bottom: 0.0,
          left: 12.0,
          right: 12.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Hero(
                tag: heroID,
                child: Poster(
                  imageUrl: movie.posterUrl,
                ),
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
}
