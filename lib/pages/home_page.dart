import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/pages/movies_list_page.dart';
import 'package:flutter_list/state/states.dart';
import 'package:flutter_list/util/util.dart';
import 'package:flutter_list/widgets/movie_list.dart';
import 'package:flutter_list/widgets/rating_information.dart';
import 'package:flutter_list/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'movie_detail_page.dart';
import 'movie_search_page.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Movie DB'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              return showSearch(context: context, delegate: MovieSearchPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('박스 오피스', style: themeData.textTheme.headline),
                  IconButton(
                    icon: Icon(
                      Icons.view_list,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviesListPage(
                              title: '박스 오피스',
                              movies: MovieDBApi.getTopRate(),
                            ),
                          ));
                    },
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: MovieDBApi.getTopRate(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MovieCoverFlow(snapshot.data.reversed.toList());
                } else {
                  return Container(
                      height: 460,
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('현재 상영중', style: themeData.textTheme.headline),
                  IconButton(
                      icon: Icon(
                        Icons.view_list,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoviesListPage(
                                title: '현재 상영중',
                                movies: MovieDBApi.getPlayNow(),
                              ),
                            ));
                      })
                ],
              ),
            ),
            FutureBuilder(
                future: MovieDBApi.getPlayNow(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new HorizontalMovieList(
                        movies: snapshot.data, name: 'play_now');
                  } else {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('나의 즐겨찾기', style: themeData.textTheme.headline),
                  Consumer<FavoriteState>(builder: (context, state, child) {
                    return IconButton(
                        icon: Icon(
                          Icons.view_list,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoviesListPage(
                                  title: '나의 즐겨찾기',
                                  movies: typeCastToFuture(state.getMovies()),
                                ),
                              ));
                        });
                  }),
                ],
              ),
            ),
            Consumer<FavoriteState>(builder: (context, state, child) {
              print('my favotite consumer : ' + state.isLoaded.toString());
              if (false == state.isLoaded) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state.isEmpty()) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Center(
                    child: Text('즐겨 찾기에 등록된 영화가 없습니다.',
                        style: themeData.textTheme.body1),
                  ),
                );
              }
              return new HorizontalMovieList(
                  movies: state.getMovies(), name: 'favorite');
            }),
          ],
        ),
      ),
    );
  }

  Future<T> typeCastToFuture<T>(T t) async {
    return t;
  }
}

class CardControllWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 10.0;
  final List<Movie> movieDataList;

  CardControllWidget(this.currentPage, this.movieDataList);

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

  MovieCoverFlowState({this.movies}) {
    currentPage = movies.length - 1.0;
    _pageIndex = currentPage.toInt();
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
                CardControllWidget(currentPage, movies),
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
                      RatingInformation(movies[_pageIndex], true)
                    ],
                  )),
            ),
          ],
        ));
  }
}
