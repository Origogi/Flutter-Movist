import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/locale/translations.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/pages/movie_detail_page.dart';
import 'package:flutter_list/util/util.dart';
import 'package:flutter_list/widgets/rating_information.dart';

import 'backdrop_image.dart';
import 'category_chips.dart';

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
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: Container(
                          margin: EdgeInsets.only(left: 125, right: 10),
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
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
                                    '${Translations.of(context)
                                    .trans(transKeyOpenDate)} : ',
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                  Text(
                                    movies[index].releaseDate,
                                    style: Theme.of(context).textTheme.body2,
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

class MovieCoverFlow extends StatefulWidget {
  final List<Movie> movies;

  MovieCoverFlow(this.movies);

  @override
  State<StatefulWidget> createState() {
    return MovieCoverFlowState(movies: movies);
  }
}

class MovieCoverFlowState extends State<MovieCoverFlow> {
  final List<Movie> movies;

  double currentPage;
  var _visible = true;
  int _pageIndex = 0;
  Future<Map<int, String>> genresMapFuture;

  MovieCoverFlowState({this.movies}) {
    currentPage = movies.length - 1.0;
    _pageIndex = currentPage.toInt();
  }

  void initState() {
    super.initState();
    
    genresMapFuture = MovieDBApi.getGenres();

  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: movies.length - 1);

    controller.addListener(() {
      setState(() {
        currentPage = controller.page;

        if (currentPage - currentPage.toInt() == 0) {
          _visible = true;
          _pageIndex = currentPage.toInt();
        } else {
          _visible = false;
        }
      });
    });

    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            Movie movie = movies[currentPage.round()];
            return MovieDetailsPage(
                movie: movie, heroID: HeroID.make(movie.id, 'box_office'));
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 250),
                    child: Hero(
                        tag: HeroID.make(movies[_pageIndex].id, 'backdrop'),
                        child: BackDropImage(movies[_pageIndex].backDropUrl))),
                Container(
                    padding: EdgeInsets.only(top: 70),
                    child: CardControllWidget(currentPage, movies)),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: movies.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                )
              ],
            ),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 250),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${movies[_pageIndex].title}',
                        style: Theme.of(context).textTheme.title,
                      ),
                      RatingInformation(movies[_pageIndex], true),
                      FutureBuilder(
                          future: genresMapFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: CategoryChips(
                                    movies[_pageIndex].genreIDs, snapshot.data),
                              );
                            } else {
                              return Container();
                            }
                          })
                    ],
                  )),
            ),
          ],
        ));
  }
}

class CardControllWidget extends StatelessWidget {
  var currentPage;
  final padding = 10.0;
  final verticalInset = 40.0;
  final List<Movie> movieDataList;

  final cardAspectRatio = 12.0 / 16.0;
  double widgetAspectRatio;

  CardControllWidget(this.currentPage, this.movieDataList) {
    widgetAspectRatio = cardAspectRatio * 1.2;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = List();

          for (var i = 0; i < movieDataList.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: Hero(
                tag: HeroID.make(movieDataList[i].id, 'box_office'),
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 4),
                            blurRadius: 6)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          FadeInImage(
                            image: NetworkImage(movieDataList[i].posterUrl),
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('assets/images/loading.gif'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
