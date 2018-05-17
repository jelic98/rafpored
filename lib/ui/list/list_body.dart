import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/network.dart';
import 'package:rafroid/model/event.dart';
import 'package:rafroid/ui/common/refresh_event_list.dart';

class ListBody extends StatefulWidget {

  final List<Event> _events;

  ListBody(this._events);

  @override
  _ListBodyState createState() => _ListBodyState(_events);
}

class _ListBodyState extends State<ListBody> {

  List<Event> events;

  _ListBodyState(this.events);

  @override
  Widget build(BuildContext context) =>
      Flexible(
        child: Container(
          child: FutureBuilder(
            future: Network.fetchEvents(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                if(!snapshot.hasData || snapshot.hasError) {
                  return Center(
                    child: Text("Nema stavki", style: Res.TextStyles.listPlaceholder),
                  );
                }else {
                  return RefreshEventList(snapshot.data);
                }
              }else {
                return Center(
                  child: Image(
                    image: AssetImage("assets/img/loading.gif"),
                  ),
                );
              }
            },
          ),
        ),
      );
}