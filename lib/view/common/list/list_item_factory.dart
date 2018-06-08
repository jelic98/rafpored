import 'package:flutter/material.dart';
import 'package:rafpored/controller/network/fetcher.dart';

abstract class ListItemFactory {

  Fetcher fetcher;

  Widget getItem(BuildContext context, dynamic item);
}