import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/widgets/movie_list.dart';

class ProfilePage extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final String heroID;

  ProfilePage(this.id, this.name, this.imageUrl, this.heroID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: heroID,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: FadeInImage(
                width: double.infinity,
                height: double.infinity,
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/images/loading.gif'),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 20, top: 450, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: MovieDBApi.getPserson(id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DetailProfileWidget(snapshot.data);
                          } else {
                            return Container(
                                height: 100,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        })
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class DetailProfileWidget extends StatelessWidget {
  final Person person;

  DetailProfileWidget(this.person);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${person.birthday}, ${person.placeOfBirth} '),
          SizedBox(
            height: 20,
          ),
          ExpandablePanel(
            header: Text('약력', style: theme.title),
            collapsed: Text(person.biography,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.body2),
            expanded:
                Text(person.biography, softWrap: true, style: theme.body2),
            tapHeaderToExpand: true,
            hasIcon: true,
          ),
          SizedBox(
            height: 20,
          ),
          Text('출연작', style: theme.title),
           SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: MovieDBApi.getMovieCredits(person.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HorizontalMovieList(
                    movies: snapshot.data, name: person.id.toString());
              } else {
                return Container(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          )
        ],
      ),
    );
  }
}
