import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta_weather_api/src/models/models.dart';

void main() {
  group('Location', ()  {
    group('fromJson', () {
      test('throws CheckFromJsonException when enum is unknown', () {
        expect(() => Location.fromJson({
          'title': 'mock-title',
          'location_type': 'Unknown',
          'latt_long': '-34.75,83.28',
          'woeid': 42
        }), throwsA(isA<CheckedFromJsonException>()));
      });
    });
  });
}