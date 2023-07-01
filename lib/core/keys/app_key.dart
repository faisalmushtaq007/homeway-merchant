import 'package:flutter/material.dart';

class AppKey {
  final snackbarKey =
      GlobalKey<ScaffoldMessengerState>(debugLabel: 'app_snackbarKey');
  final navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'app_navigatorKey');
}

/*
Types of keys
There are four types of keys in Flutter, which are as follows:

Value key: It stores the alphanumeric value of the widget.

Object key: It stores complex objects in which multiple objects
have the same values, such as date of birth or name.
It usually would be a custom class.

Unique key: It stores every widget state as unique.
It is easy to identify them when we need to recall them.

Global key: It allows developers to access the data of
one widget inside another in your application. It can help the developers
but can also destroy the state management. It is a very controversial key
as better state management options are available.
It can be helpful in form validation situations where we need
to validate some common data.
*/
