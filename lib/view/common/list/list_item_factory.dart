import 'package:flutter/material.dart';

abstract class ListItemFactory {

  Widget getItem(BuildContext context, dynamic item);
}