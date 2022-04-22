import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_project/weather/helpers/hydrated_bloc.dart';
import 'package:test_project/weather/theme/cubit/theme_cubit.dart';
import 'package:test_project/weather/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

class MockWeather extends Mock implements Weather {
  MockWeather(this._condition);

  final weather_repository.WeatherCondition _condition;

  @override
  weather_repository.WeatherCondition get condition => _condition;
}

void main() {
  group('ThemeCubit', () {
    test('initial state is correct', () {
      mockHydratedStorage(() {
        expect(ThemeCubit().state, ThemeCubit.defaultColor);
      });
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final themeCubit = ThemeCubit();
          expect(themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
              themeCubit.state);
        });
      });
    });

    group('updateTheme', () {
      final clearWeather =
          MockWeather(weather_repository.WeatherCondition.clear);
      final snowyWeather =
          MockWeather(weather_repository.WeatherCondition.snowy);
      final cloudyWeather =
          MockWeather(weather_repository.WeatherCondition.cloudy);
      final rainyWeather =
          MockWeather(weather_repository.WeatherCondition.rainy);
      final unknownWeather =
          MockWeather(weather_repository.WeatherCondition.unknown);

      late ThemeCubit themeCubit;

      setUp(() async {
        themeCubit = await mockHydratedStorage(() => ThemeCubit());
      });

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.clear',
        build: () => themeCubit,
        act: (cubit) => cubit.updateTheme(clearWeather),
        expect: () => [Colors.orangeAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.snowy',
        build: () => themeCubit,
        act: (cubit) => cubit.updateTheme(snowyWeather),
        expect: () => <Color>[Colors.lightBlueAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.cloudy',
        build: () => themeCubit,
        act: (cubit) => cubit.updateTheme(cloudyWeather),
        expect: () => <Color>[Colors.blueGrey],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.rainy',
        build: () => themeCubit,
        act: (cubit) => cubit.updateTheme(rainyWeather),
        expect: () => <Color>[Colors.indigoAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.unknown',
        build: () => themeCubit,
        act: (cubit) => cubit.updateTheme(unknownWeather),
        expect: () => <Color>[ThemeCubit.defaultColor],
      );
    });
  });
}
