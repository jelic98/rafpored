import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/page/details/details_body.dart';

class NewsDetails extends DetailsBodyState {
  
  NewsDetails(item) : super(item);

  @override
  Widget build(BuildContext context) =>
      Expanded(
        child: Container(
          child: Hero(
            tag: "hero-news-" + item.id,
            child: Material(
              color: Res.Colors.newsColor,
              child: Padding(
                padding: EdgeInsets.all(Res.Dimens.cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(item.title, style: Res.TextStyles.textFull),
                    ),
                    Container(height: Res.Dimens.dividerSmall),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.event,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon,
                        ),
                        Container(width: Res.Dimens.smallIconSpacing),
                        Text(
                          item.getDate(),
                          style: Res.TextStyles.textFaded,
                        ),
                      ],
                    ),
                    (item.update != null && Res.Strings.updates[item.update].isNotEmpty) ?
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.flag,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon,
                        ),
                        Container(width: Res.Dimens.smallIconSpacing),
                        Text(
                          Res.Strings.updates[item.update],
                          style: Res.TextStyles.textFaded,
                        ),
                      ],
                    ) : Container(height: 0.0),
                    Container(height: Res.Dimens.dividerSmall),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(item.text, style: Res.TextStyles.textFaded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}