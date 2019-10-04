import 'package:flutter/material.dart';
import 'package:flutter_list/MovieDetailPage.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

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
      backgroundColor: Color(0xFF2d3447),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 12, right: 12, top: 50, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('최신 영화',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46.0,
                        fontFamily: 'Calibre-Semibold',
                        letterSpacing: 1.0)),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
              future: MovieDBApi.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  MovieDBApiResponse response =
                      snapshot.data as MovieDBApiResponse;
                  return FlatButton(
                    child: MyStack(response),
                    onPressed: () {
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
          )
        ],
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
    print('cardControl');
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

                        // SingleChildScrollView(
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Padding(
                        //         padding: const EdgeInsets.only(
                        //             left: 12.0, bottom: 12.0, top: 300),

                        //           child: Text(movieDataList[i].title,
                        //               style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 25.0,
                        //                   fontFamily: 'SF-Pro-Text-Regular')),
                        //         ),

                        //     ],
                        //   ),
                        // ),

                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0,top: 300),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Text(movieDataList[i].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: 'SF-Pro-Text-Regular')),
                                ),
                              )
                            ],
                          ),
                        )
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
