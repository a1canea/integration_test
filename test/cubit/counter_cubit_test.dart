import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/flutter_ly_bloc/bl/cubit/counter_cubit.dart';
import 'package:test_project/flutter_ly_bloc/bl/cubit/counter_state.dart';

void main() {
  group('Counter Cubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test('CounterCubit initial state is - 0', () {
      expect(counterCubit.state,
          CounterState(currentValue: 0, isIncremented: false));
    });

    blocTest<CounterCubit, CounterState>(
      'CounterCubit should emit CounterState(currentValue: 1, isIncremented: true)',
      build: () => counterCubit,
      act: (bloc) => bloc.increment(),
      expect: () => [CounterState(currentValue: 1, isIncremented: true)],
    );
    blocTest<CounterCubit, CounterState>(
      'CounterCubit should emit CounterState(currentValue: -1, isIncremented: false)',
      build: () => counterCubit,
      act: (bloc) => bloc.decrement(),
      expect: () => [CounterState(currentValue: -1, isIncremented: false)],
    );
    blocTest<CounterCubit, CounterState>(
      'CounterCubit should emit CounterState(currentValue: 0, isIncremented: true)',
      build: () => counterCubit,
      act: (bloc) {
        bloc.decrement();
        bloc.increment();
      },
      expect: () => [
        CounterState(currentValue: -1, isIncremented: false),
        CounterState(currentValue: 0, isIncremented: true)
      ],
    );
  });
}
