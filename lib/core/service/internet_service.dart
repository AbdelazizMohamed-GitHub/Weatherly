import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  InternetService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  late final Stream<bool> connectionChanges =
      _watchConnectionChanges().distinct().asBroadcastStream();

  Stream<bool> _watchConnectionChanges() async* {
    yield _isConnected(await _connectivity.checkConnectivity());
    yield* _connectivity.onConnectivityChanged.map(_isConnected);
  }

  bool _isConnected(List<ConnectivityResult> results) =>
      !results.contains(ConnectivityResult.none);
}
