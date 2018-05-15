import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;
import 'package:rafroid/Routes.dart';
import 'package:rafroid/Network.dart';
import 'package:rafroid/model/Event.dart';

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
          future: new Network().fetchEvents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new Text('Učitavanje...');
              default:
                if(snapshot.hasError) {
                  return new Text('Greška: ${snapshot.error}');
                }else {
                  List<Event> events = snapshot.data;

                  return new ListView.builder(
                    padding: EdgeInsets.only(top: Theme.Dimens.listPadding, bottom: Theme.Dimens.listPadding),
                    itemExtent: Theme.Dimens.listItemExtent,
                    itemCount: events.length,
                    itemBuilder: (context, index) => _getListRow(events[index]),
                  );
                }
            }
          },
        ),
      ),
    );
  }

  Widget _getListRow(Event event) {
    return new Container(
      margin: EdgeInsets.only(top: Theme.Dimens.cardMargin, bottom: Theme.Dimens.cardMargin),
      child: new MaterialButton(
          onPressed: () => Routes.navigate(context, '/details/${event.id}', false, Transition.start),
          child: new Material(
            borderRadius: new BorderRadius.circular(Theme.Dimens.cardRadius),
            color: event.getColor(),
            elevation: Theme.Dimens.elevation,
            child: new Container(
              margin: EdgeInsets.all(Theme.Dimens.cardPadding),
              constraints: new BoxConstraints.expand(),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new FittedBox(
                      fit: BoxFit.scaleDown,
                      child: new Text(event.subject, style: Theme.TextStyles.textFull)),
                  new FittedBox(
                      fit: BoxFit.scaleDown,
                      child: new Text(event.professor, style: Theme.TextStyles.textFaded)),
                  new Container(
                      height: Theme.Dimens.dividerSmall
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.location_on,
                            size: Theme.Dimens.smallIconSize,
                            color: Theme.Colors.smallIcon,
                          ),
                          new Container(width: Theme.Dimens.smallIconSpacing),
                          new Text(
                              event.getClassrooms(),
                              style: Theme.TextStyles.textFaded
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(
                              Icons.calendar_today,
                              size: Theme.Dimens.smallIconSize,
                              color: Theme.Colors.smallIcon
                          ),
                          new Container(width: Theme.Dimens.smallIconSpacing),
                          new Text(
                              event.getDateFrom()["date"],
                              style: Theme.TextStyles.textFaded
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Icon(
                              Icons.access_time,
                              size: Theme.Dimens.smallIconSize,
                              color: Theme.Colors.smallIcon
                          ),
                          new Container(width: Theme.Dimens.smallIconSpacing),
                          new Text(
                              event.getDateFrom()["time"],
                              style: Theme.TextStyles.textFaded
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}