import 'package:flutter/material.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/pages/movies_list_page.dart';
import 'package:flutter_list/state/states.dart';

import 'package:flutter_list/widgets/movie_list.dart';
import 'package:flutter_list/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'movie_search_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Future<List<Movie>> playNowMoviesFuture;
  Future<List<Movie>> popularMoviesFuture;

  @override
  void initState() {
    super.initState();
    playNowMoviesFuture = MovieDBApi.getPlayNow();
    popularMoviesFuture = MovieDBApi.getTopRate();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Movist'),
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
              future: popularMoviesFuture,
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
                future: playNowMoviesFuture,
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
