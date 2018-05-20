import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/model/event.dart';

class EventList extends StatefulWidget {

  final List<Event> events;

  EventList(this.events);

  @override
  EventListState createState() => EventListState(events);
}

class EventListState extends State<EventList> {

  List<Event> events;

  EventListState(List<Event> events) {
    this.events = events ?? List<Event>();
  }

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).orientation == Orientation.portrait || events.length == 1) {
      return ListView.builder(
        padding: EdgeInsets.only(top: Res.Dimens.listPadding, bottom: Res.Dimens.listPadding),
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) => _buildRow(context, events[index]),
      );
    }else {
      return GridView.count(
        padding: EdgeInsets.only(top: Res.Dimens.listPadding, bottom: Res.Dimens.listPadding),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        children: events.map((event) => _buildRow(context, event)).toList(),
      );
    }
  }

  Widget _buildRow(BuildContext context, Event event) =>
      Container(
        margin: EdgeInsets.only(top: Res.Dimens.cardMargin, bottom: Res.Dimens.cardMargin),
        child: MaterialButton(
            onPressed: () => Routes.navigate(context, "/details", false, bundle: event),
            child: Material(
              borderRadius: BorderRadius.circular(Res.Dimens.cardRadius),
              color: event.getColor(),
              elevation: Res.Dimens.cardElevation,
              child: Container(
                margin: EdgeInsets.all(Res.Dimens.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(event.subject, style: Res.TextStyles.textFull)),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(event.professor, style: Res.TextStyles.textFaded)),
                    Container(height: Res.Dimens.dividerSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: Res.Dimens.smallIconSize,
                              color: Res.Colors.smallIcon,
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                                event.getClassrooms(),
                                style: Res.TextStyles.textFaded
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                                Icons.calendar_today,
                                size: Res.Dimens.smallIconSize,
                                color: Res.Colors.smallIcon
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                                event.getDateFrom()["date"],
                                style: Res.TextStyles.textFaded
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                                Icons.access_time,
                                size: Res.Dimens.smallIconSize,
                                color: Res.Colors.smallIcon
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                                event.getDateFrom()["time"],
                                style: Res.TextStyles.textFaded
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