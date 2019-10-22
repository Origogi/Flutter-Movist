import 'package:flutter/material.dart';

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
                                Text(themes[index], style: style)
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      print("tap");
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: index == 1
                                          ? Icon(Icons.done,
                                              color: Theme.of(context).accentColor)
                                          : Container(),
                                    ),
                                  ),
                                ),
                                Text(themes[index], style: style)
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
