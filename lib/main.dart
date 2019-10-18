import 'package:flutter/material.dart';
import 'package:flutter_list/MovieDetailPage.dart';
import 'package:flutter_list/MovieListView.dart';
import 'package:flutter_list/model/FavoriteModel.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'dart:math';

import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<FavoriteModel>(
          builder: (_) => FavoriteModel(),
          child: MaterialApp(
            home: MyApp(),
            debugShowCheckedModeBanner: false,
          )),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

double currentPage;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text('Movie DB'),
        backgroundColor: Color(0xFF2d3447),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Trending',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontFamily: 'Calibre-Semibold',
                          letterSpacing: 1.0)),
                ],
              ),
            ),
            FutureBuilder(
              future: MovieDBApi.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  MovieDBApiResponse response =
                      snapshot.data as MovieDBApiResponse;
                  return GestureDetector(
                    child: MyStack(response),
                    onTapDown: (_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(
                                response.results[currentPage.toInt()])),
                      );
                    },
                  );
                } else {
                  return Padding(
                      padding: EdgeInsets.all(100),
                      child: CircularProgressIndicator());
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('My List',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontFamily: 'Calibre-Semibold',
                          letterSpacing: 1.0)),
                ],
              ),
            ),
            Consumer<FavoriteModel>(builder: (context, model, child) {
              if (model.isEmpty()) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Center(
                    child: Text('즐겨 찾기에 등록된 영화가 없습니다.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'SF-Pro-Text-Regular',
                            letterSpacing: 1.0)),
                  ),
                );
              }

              return FutureBuilder(
                future: MovieDBApi.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MovieDBApiResponse response =
                        snapshot.data as MovieDBApiResponse;
                    var favoriteMovieList = response.results.where((item) {
                      return model.containMovieID(item.id);
                    }).toList();
                    return MovieListView(favoriteMovieList);
                  } else {
                    return Padding(
                        padding: EdgeInsets.all(100),
                        child: CircularProgressIndicator());
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class CardControllWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  List<Movie> movieDataList;

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(3.9, 6.0),
                        blurRadius: 10.0)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(movieDataList[i].posterUrl,
                            fit: BoxFit.fill),
                      ],
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

class MyStack extends StatefulWidget {
  MovieDBApiResponse apiResponse;

  MyStack(this.apiResponse);

  @override
  State<StatefulWidget> createState() {
    print('MyStack');
    return MyStackState(apiResponse);
  }
}

class MyStackState extends State<MyStack> {
  MovieDBApiResponse apiResponse;

  MyStackState(MovieDBApiResponse apiResponse) {
    this.apiResponse = apiResponse;
    print(apiResponse.toString());
    currentPage = this.apiResponse.results.length - 1.0;
  }

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: apiResponse.results.length - 1);

    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Stack(
      children: <Widget>[
        CardControllWidget(currentPage, apiResponse.results),
        Positioned.fill(
          child: PageView.builder(
            itemCount: apiResponse.results.length,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        )
      ],
    );
  }
}

class Sidebar extends StatelessWidget {
  final List<Color> colors = [Colors.white, Color(0xff242248), Colors.black];
  final List<Color> borders = [Colors.black, Colors.white, Colors.white];
  final List<String> themes = ['Light', 'Dark', 'Amoled'];


  @override
  Widget build(BuildContext context) {

    var style = TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: 'Calibre-Semibold',
        letterSpacing: 1.0);

    return Drawer(
      child: Container(
          color: Color(0xFF2d3447),
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Theme',
                        // style: state.themeData.textTheme.body2,
                        style: style),
                  ],
                ),
                subtitle: SizedBox(
                  height: 100,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: borders[index]),
                                        color: colors[index]),
                                  ),
                                ),
                                Text(themes[index],
                                    style: style)
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      // child: Theme.of(context).primaryColor ==
                                      //         colors[index]
                                      //     ? Icon(Icons.done,
                                      //         color:
                                      //             Theme.of(context).accentColor)
                                      //     : Container(),
                                      child: index == 0
                                          ? Icon(Icons.done,
                                              color:
                                                  Theme.of(context).accentColor)
                                          : Container(),
                                    ),
                                  ),
                                ),
                                Text(themes[index],
                                    style: style)
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
