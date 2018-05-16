import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;
import 'package:rafroid/routes.dart';
import 'package:rafroid/model/event.dart';

class EventList extends StatelessWidget {

  final List<Event> _events;

  EventList(this._events);

  @override
  Widget build(BuildContext context) =>
      ListView.builder(
        padding: EdgeInsets.only(top: Res.Dimens.listPadding, bottom: Res.Dimens.listPadding),
        itemCount: _events.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildRow(context, _events[index]),
      );

  Widget _buildRow(BuildContext context, Event event) =>
      Container(
        margin: EdgeInsets.only(top: Res.Dimens.cardMargin, bottom: Res.Dimens.cardMargin),
        child: MaterialButton(
            onPressed: () => Routes.navigate(context, "/details", false, bundle: event),
            child: Material(
              borderRadius: BorderRadius.circular(Res.Dimens.cardRadius),
              color: event.getColor(),
              elevation: Res.Dimens.elevation,
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