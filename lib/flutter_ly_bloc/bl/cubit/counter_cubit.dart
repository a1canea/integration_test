
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  // number '1' is for StreamSubscription listening logic

  // 1 final InternetCubit _internetCubit;
  // 1 late final StreamSubscription _internetStreamSubscription;

  CounterCubit() : super(CounterState(currentValue: 0, isIncremented: false));
  // 1 CounterCubit(
  //   InternetCubit internetCubit,
  // )   : _internetCubit = internetCubit,
  //       super(CounterState(currentValue: 0, isIncremented: false)) {
  //   _internetStreamSubscription = _internetCubit.stream.listen((event) {
  //     if (event is InternetConnected &&
  //         event.connectionType == ConnectionType.Wifi) {
  //       increment();
  //     } else if (event is InternetConnected &&
  //         event.connectionType == ConnectionType.Mobile) {
  //       decrement();
  //     }
  //   });
  // }

  void increment() {
    emit(CounterState(
        currentValue: state.currentValue + 1, isIncremented: true));
  }

  void decrement() {
    emit(CounterState(
        currentValue: state.currentValue - 1, isIncremented: false));
  }

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    return state.toMap();
  }

// 1 @override
  // Future<void> close() {
  //   _internetStreamSubscription.cancel();
  //
  //   return super.close();
  // }
}
