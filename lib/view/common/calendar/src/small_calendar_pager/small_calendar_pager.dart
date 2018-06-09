import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'pager_position.dart';
import 'small_calendar_pager_controller.dart';

/// Signature for a function that creates a widget for a given [month].
///
/// All values of [month] except year and month are set to their default values.
typedef Widget SmallCalendarPageBuilder(BuildContext context, DateTime month);

/// A scrollable list of Pages each representing a month.
class SmallCalendarPager extends StatefulWidget {
  SmallCalendarPager._internal({
    @required this.scrollDirection,
    @required this.controller,
    @required this.pageBuilder,
    this.onMonthChanged,
  })  : assert(scrollDirection != null),
        assert(controller != null),
        assert(pageBuilder != null);

  factory SmallCalendarPager({
    Axis scrollDirection = Axis.horizontal,
    SmallCalendarPagerController controller,
    @required SmallCalendarPageBuilder pageBuilder,
    ValueChanged<DateTime> onMonthChanged,
  }) {
    controller ??= new SmallCalendarPagerController();

    return new SmallCalendarPager._internal(
      scrollDirection: scrollDirection,
      controller: controller,
      pageBuilder: pageBuilder,
      onMonthChanged: onMonthChanged,
    );
  }

  /// The axis along which the pager scrolls.
  final Axis scrollDirection;

  /// An object that can be used to control the month displayed in the pager.
  final SmallCalendarPagerController controller;

  /// Function that builds the widgets displayed inside the pager.
  final SmallCalendarPageBuilder pageBuilder;

  /// Called whenever the displayed month changes.
  final ValueChanged<DateTime> onMonthChanged;

  @override
  _SmallCalendarPagerState createState() => new _SmallCalendarPagerState();
}

class _SmallCalendarPagerState extends State<SmallCalendarPager> {
  /// This widget is basically a wrapper around this [PageView].
  PageView _pageView;

  /// Controller for the internally user [PageView].
  PageController _pageController;

  /// Currently displayed page in the internal [PageView].
  int _displayedPage;

  @override
  void initState() {
    super.initState();

    _pageController = _createPageController();
    _pageView = _createPageView();
    widget.controller.attach(_createPagerPosition());
  }

  @override
  void didUpdateWidget(SmallCalendarPager oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller ||
        oldWidget.scrollDirection != widget.scrollDirection) {
      _pageController = _createPageController();
      _pageView = _createPageView();

      oldWidget.controller.detach();
      widget.controller.attach(_createPagerPosition());
    }
  }

  PageController _createPageController() {
    _displayedPage = widget.controller.initialPage;

    return new PageController(
      initialPage: _displayedPage,
    );
  }

  PageView _createPageView() {
    return new PageView.builder(
      scrollDirection: widget.scrollDirection,
      controller: _pageController,
      itemCount: widget.controller.numOfPages,
      itemBuilder: (BuildContext context, int index) {
        DateTime month = widget.controller.monthOf(index);

        return widget.pageBuilder(context, month);
      },
    );
  }

  PagerPosition _createPagerPosition() {
    void onJumpToPage(int index) {
      _pageController.jumpToPage(index);
    }

    void onAnimateToPage(int page, Duration duration, Curve curve) {
      _pageController.animateToPage(
        page,
        duration: duration,
        curve: curve,
      );
    }

    int onGetPage() {
      return _displayedPage;
    }

    return new PagerPosition(
      jumpToPage: onJumpToPage,
      animateToPage: onAnimateToPage,
      getPage: onGetPage,
    );
  }

  void _onScrollEnded() {
    int newPage = _pageController.page.toInt();

    if (newPage != _displayedPage) {
      _displayedPage = newPage;

      if (widget.onMonthChanged != null) {
        DateTime displayedMonth = widget.controller.monthOf(_displayedPage);
        widget.onMonthChanged(displayedMonth);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification value) {
        if (value is ScrollEndNotification) {
          _onScrollEnded();
        }
      },
      child: _pageView,
    );
  }
}
