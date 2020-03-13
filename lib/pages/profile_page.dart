import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/locale/translations.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/widgets/back_button.dart';
import 'package:flutter_list/widgets/movie_list.dart';

class ProfilePage extends StatefulWidget {
  final int id;
  final String name;
  final String imageUrl;
  final String heroID;

  ProfilePage({this.id, this.name, this.imageUrl, this.heroID});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState(
        id: id, name: name, imageUrl: imageUrl, heroID: heroID);
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final int id;
  final String name;
  final String imageUrl;
  final String heroID;

  Future<Person> personFuture;
  Future<List<Movie>> creditsMoviesFuture;

  _ProfilePageState({this.id, this.name, this.imageUrl, this.heroID});

  void initState() {
    super.initState();

    personFuture = MovieDBApi.getPerson(id);
    creditsMoviesFuture = MovieDBApi.getMovieCredits(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  height: 450,
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/images/loading.gif'),
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.only(top: 450),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    color: Theme.of(context).backgroundColor.withOpacity(0.3),
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
                            future: personFuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DetailProfileWidget(snapshot.data);
                              } else {
                                return Container(
                                    height: 100,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(Translations.of(context)
                                    .trans(transKeyBiography), style: Theme.of(context).textTheme.title),
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                          future: creditsMoviesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return HorizontalMovieList(
                                  movies: snapshot.data, name: id.toString());
                            } else {
                              return Container(
                                  height: 100,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                          },
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: CustomBackButton()),
          ],
        ),
      ),
    );
  }
}

class DetailProfileWidget extends StatefulWidget {
  final Person person;

  DetailProfileWidget(this.person);

  @override
  State<StatefulWidget> createState() {
    return DetailProfileWidgetState(person);
  }
}

class DetailProfileWidgetState extends State<DetailProfileWidget> {
  final Person person;

  DetailProfileWidgetState(this.person);

  void initState() {
    super.initState();
  }

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
            header: Text(Translations.of(context).trans(transKeyKnowFor),
                style: theme.title),
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
        ],
      ),
    );
  }
}
