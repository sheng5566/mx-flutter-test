import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class API {
  static String fakeStoreAPI = 'https://fakestoreapi.com/products';
}

class Constant {
  static Color backgroundColor = Color.fromARGB(255, 7, 19, 37);
  static Color color1 = Color.fromARGB(255, 159, 0, 0);
  static Color color2 = Color.fromARGB(255, 255, 208, 0);

  static String formattedDate(DateTime date) {
    // print(date.toLocal());
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formattedDateMonth(DateTime date) {
    // print(date.toLocal());
    return DateFormat('Md').format(date);
  }

  static String formattedHMTime(DateTime date) {
    // print(date.toLocal());
    return DateFormat('Hm').format(date);
  }

  static bool datetimeIsToday(String date) {
    return Constant.formattedDate(DateTime.parse(date)) ==
        Constant.formattedDate(DateTime.now());
  }

  static String formattedTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String dateName(DateTime date) {
    return DateFormat('EEEE').format(date);

    /// e.g Thursday
  }

  static Function deepEq = const DeepCollectionEquality.unordered().equals;
}
