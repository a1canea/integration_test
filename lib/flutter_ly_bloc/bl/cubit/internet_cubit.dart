import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity;
  late final StreamSubscription _connectivityStreamSubscription;

  InternetCubit(
    Connectivity connectivity,
  )   : _connectivity = connectivity,
        super(InternetLoading()) {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.wifi:
          emitInternetConnected(ConnectionType.Wifi);
          break;
        case ConnectivityResult.mobile:
          emitInternetConnected(ConnectionType.Mobile);
          break;
        default:
          emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();

    return super.close();
  }
}
