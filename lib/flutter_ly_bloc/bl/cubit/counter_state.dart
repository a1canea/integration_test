import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterState with EquatableMixin {
  final int currentValue;
  final bool isIncremented;

  CounterState({
    required this.currentValue,
    required this.isIncremented,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentValue': currentValue,
      'isIncremented': isIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      currentValue: map['currentValue'],
      isIncremented: map['isIncremented'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [currentValue, isIncremented];

  @override
  String toString() {
    return 'CounterState{currentValue: $currentValue, isIncremented: $isIncremented}';
  }
}
