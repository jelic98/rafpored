import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/view/common/list/list_item_factory.dart';

class NewsItemFactory extends ListItemFactory {

  @override
  Widget getItem(BuildContext context, dynamic news) {
    return Container(
      margin: EdgeInsets.only(
          left: Res.Dimens.cardMargin,
          right: Res.Dimens.cardMargin,
          bottom: Res.Dimens.cardMargin
      ),
      child: Hero(
        tag: "hero-news-" + news.id,
        child: Material(
          borderRadius: BorderRadius.circular(Res.Dimens.cardRadius),
          color: Res.Colors.newsColor,
          elevation: Res.Dimens.cardElevation,
          child: MaterialButton(
            onPressed: () => Routes.navigate(context, "/details-news", false, bundle: news),
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
                    child: Text(news.title, style: Res.TextStyles.textFull),
                  ),
                  Text(
                      news.text,
                      style: Res.TextStyles.textFaded,
                      overflow: TextOverflow.ellipsis,
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
                        news.getDate(),
                        style: Res.TextStyles.textFaded,
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
}