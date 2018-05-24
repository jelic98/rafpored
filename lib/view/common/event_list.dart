import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/model/event.dart';

class EventList extends StatefulWidget {

  List<Event> events;

  EventListState _state;

  EventList(this.events) {
    _state = EventListState(events);
  }

  @override
  EventListState createState() => _state;

  setEvents(List<Event> events) {
    this.events = events;
    _state.setEvents(events);
  }
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
        padding: EdgeInsets.only(top: Res.Dimens.listPadding),
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) => _buildRow(context, events[index]),
      );
    }else {
      return GridView.count(
        padding: EdgeInsets.only(top: Res.Dimens.listPadding),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        children: events.map((event) => _buildRow(context, event)).toList(),
      );
    }
  }

  Widget _buildRow(BuildContext context, Event event) =>
      Container(
        margin: EdgeInsets.only(
            left: Res.Dimens.cardMargin,
            right: Res.Dimens.cardMargin,
            bottom: Res.Dimens.cardMargin
        ),
        child: Hero(
          tag: "hero-event-" + event.id,
          child: Material(
            borderRadius: BorderRadius.circular(Res.Dimens.cardRadius),
            color: event.getColor(),
            elevation: Res.Dimens.cardElevation,
            child: MaterialButton(
              onPressed: () => Routes.navigate(context, "/details", false, bundle: event),
              child: Container(
                margin: EdgeInsets.only(
                    top: Res.Dimens.cardPadding * 0.5,
                    bottom: Res.Dimens.cardPadding,
                ),
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
                              event.classroom,
                              style: Res.TextStyles.textFaded,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.event,
                              size: Res.Dimens.smallIconSize,
                              color: Res.Colors.smallIcon,
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                              event.getDate(),
                              style: Res.TextStyles.textFaded,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: Res.Dimens.smallIconSize,
                              color: Res.Colors.smallIcon,
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                              event.getTimeStart(),
                              style: Res.TextStyles.textFaded,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  setEvents(List<Event> events) {
    // todo setState(() => this.events = events);
  }
}