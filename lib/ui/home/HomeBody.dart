import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;
import 'package:rafroid/Network.dart';
import 'package:rafroid/model/Subject.dart';
import 'package:rafroid/ui/home/SubjectRow.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => new _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new Container(
        color: Theme.Colors.pageBackground,
        child: new FutureBuilder(
          future: new Network().fetchSubjects(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new Text('Učitavanje...');
              default:
                if(snapshot.hasError) {
                  return new Text('Greška: ${snapshot.error}');
                }else {
                  List<Subject> subjects = snapshot.data;

                  return new ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    itemExtent: 160.0,
                    itemCount: subjects.length,
                    itemBuilder: (context, index) => new SubjectRow(subjects[index]),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}