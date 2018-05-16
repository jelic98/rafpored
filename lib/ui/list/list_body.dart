import 'package:flutter/material.dart';
import 'package:rafroid/styles.dart' as Styles;
import 'package:rafroid/routes.dart';
import 'package:rafroid/network.dart';
import 'package:rafroid/model/event.dart';

class ListBody extends StatefulWidget {

  @override
  _ListBodyState createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        child: FutureBuilder(
          future: Network().fetchEvents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Učitavanje...", style: Styles.TextStyles.listPlaceholder),
                );
              default:
                if(snapshot.hasError) {
                  return Center(
                    child: Text("Greška: ${snapshot.error}", style: Styles.TextStyles.listPlaceholder),
                  );
                }else {
                  List<Event> events = snapshot.data;

                  return ListView.builder(
                    padding: EdgeInsets.only(top: Styles.Dimens.listPadding, bottom: Styles.Dimens.listPadding),
                    itemExtent: Styles.Dimens.listItemExtent,
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
    return Container(
      margin: EdgeInsets.only(top: Styles.Dimens.cardMargin, bottom: Styles.Dimens.cardMargin),
      child: MaterialButton(
          onPressed: () => Routes.navigate(context, "/details", false, bundle: [event]),
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
                ],
              ),
            ),
          )
      ),
    );
  }
}