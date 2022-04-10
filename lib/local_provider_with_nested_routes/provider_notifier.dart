import 'dart:math';

import 'package:flutter/foundation.dart';

class ProviderNotifier extends ChangeNotifier {
  String value = '';

  void updateValue() {
    final rnd = Random().nextInt(values.length);
    value = values[rnd];

    notifyListeners();
  }

  static List<String> values = ['1', '2', '3', '4', '5'];
}