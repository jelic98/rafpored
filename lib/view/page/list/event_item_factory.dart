import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/controller/network/event_fetcher.dart';
import 'package:rafpored/view/common/list/list_item_factory.dart';

class EventItemFactory extends ListItemFactory {

  EventItemFactory() {
    fetcher = EventFetcher();
  }

  @override
  Widget getItem(BuildContext context, dynamic event) =>
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
            color: event.type.color,
            elevation: Res.Dimens.cardElevation,
            child: MaterialButton(
              onPressed: () => Routes.navigate(context, "/details-event", false, bundle: event),
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
                      child: Text(event.subject, style: Res.TextStyles.textFull),
                    ),
                    Text(event.professor, style: Res.TextStyles.textFaded),
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
}