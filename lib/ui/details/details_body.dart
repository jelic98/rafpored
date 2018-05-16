import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/routes.dart';
import 'package:rafroid/model/event.dart';

class DetailsBody extends StatefulWidget {

  final List<Event> _events;

  DetailsBody(this._events);

  @override
  _DetailsBodyState createState() => _DetailsBodyState(_events);
}

class _DetailsBodyState extends State<DetailsBody> {

  final List<Event> _events;

  _DetailsBodyState(this._events);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          child: ListView.builder(
            padding: EdgeInsets.only(top: Styles.Dimens.listPadding, bottom: Styles.Dimens.listPadding),
            itemExtent: Styles.Dimens.listItemExtent,
            itemCount: _events.length,
            itemBuilder: (context, index) => _getListRow(_events[index]),
        )
      ),
    );
  }

  Widget _getListRow(Event event) {
    return Container(
      margin: EdgeInsets.only(top: Styles.Dimens.cardMargin, bottom: Styles.Dimens.cardMargin),
      child: MaterialButton(
          onPressed: () => Routes.navigate(context, "/details", false, Transition.start, bundle: [event]),
          child: Material(
            borderRadius: BorderRadius.circular(Styles.Dimens.cardRadius),
            color: event.getColor(),
            elevation: Styles.Dimens.elevation,
            child: Container(
              margin: EdgeInsets.all(Styles.Dimens.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(event.subject, style: Styles.TextStyles.textFull)),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(event.professor, style: Styles.TextStyles.textFaded)),
                  Container(height: Styles.Dimens.dividerSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: Styles.Dimens.smallIconSize,
                            color: Styles.Colors.smallIcon,
                          ),
                          Container(width: Styles.Dimens.smallIconSpacing),
                          Text(
                              event.getClassrooms(),
                              style: Styles.TextStyles.textFaded
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                              Icons.calendar_today,
                              size: Styles.Dimens.smallIconSize,
                              color: Styles.Colors.smallIcon
                          ),
                          Container(width: Styles.Dimens.smallIconSpacing),
                          Text(
                              event.getDateFrom()["date"],
                              style: Styles.TextStyles.textFaded
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                              Icons.access_time,
                              size: Styles.Dimens.smallIconSize,
                              color: Styles.Colors.smallIcon
                          ),
                          Container(width: Styles.Dimens.smallIconSpacing),
                          Text(
                              event.getDateFrom()["time"],
                              style: Styles.TextStyles.textFaded
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: Styles.Dimens.dividerSmall),
                  Text(
                      event.notes,
                      style: Styles.TextStyles.textFaded
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}