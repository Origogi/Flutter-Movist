import 'package:flutter/material.dart';
import 'package:flutter_list/network/data.dart';
import 'package:flutter_list/ui/ArcBannerImage.dart';
import 'package:flutter_list/ui/Poster.dart';
import 'package:flutter_list/ui/RatingInformation.dart';
import 'package:flutter_list/ui/Stroyline.dart';


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
            MovieDetailHeader(movie),
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

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    List<String> category = ['Comic', 'Action'];
    return category.map((category) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(category),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
    // return movie.categories.map((category) {
    //   return Padding(
    //     padding: const EdgeInsets.only(right: 8.0),
    //     child: Chip(
    //       label: Text(category),
    //       labelStyle: textTheme.caption,
    //       backgroundColor: Colors.black12,
    //     ),
    //   );
    // }).toList();
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
        Row(children: _buildCategoryChips(textTheme)),
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
