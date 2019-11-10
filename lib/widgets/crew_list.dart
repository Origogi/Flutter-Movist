import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/pages/profile_page.dart';
import 'package:flutter_list/util/util.dart';

class CrewList extends StatelessWidget {
  final List<Crew> crews;

  CrewList({this.crews});

  final _imageHeight = 140.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _imageHeight + 70,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: crews.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(index);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                Crew crew = crews[index];
                return ProfilePage(
                    id: crew.id,
                    name: crew.name,
                    imageUrl: crew.profileUrl,
                    heroID: HeroID.make(crew.id, 'crew'));
              }));
            },
            child: Container(
              width: _imageHeight * 0.85,
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: HeroID.make(crews[index].id, 'crew'),
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
                              image: NetworkImage(crews[index].profileUrl),
                              fit: BoxFit.cover,
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                            ))),
                  ),
                  Text(crews[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
