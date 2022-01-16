import 'dart:async';
import 'dart:math';

import 'package:tf_data_streamer/tf_data_streamer.dart';

enum AuthStatus {
  signedIn,
  signedOut,
  notVerified,
  restricted,
}

AuthStatus getFakeAuthStatusFromServer() {
  final authStatuses = AuthStatus.values;
  final index = Random().nextInt(authStatuses.length + 1);
  if (index >= authStatuses.length) {
    throw Exception('Error');
  }
  return authStatuses[index];
}

class AuthListener extends TfDataStreamer<AuthStatus> {
  late AuthStatus _currentAuthStatus;

  AuthStatus get currentAuthStatus {
    return _currentAuthStatus;
  }

  @override
  void reload() {
    try {
      _currentAuthStatus = getFakeAuthStatusFromServer();
      addData(currentAuthStatus);
    } on Exception catch (e) {
      addError(e);
    }
  }
}

void main() {
  final authStatusListener = AuthListener();
  authStatusListener.init();

  authStatusListener.stream.listen((event) {
    print('Auth Status Changed to $event');
  }, onError: (error) {
    print('Failed to get latest Auth Status.');
  });

  Timer.periodic(Duration(seconds: 3), (timer) {
    authStatusListener.reload();
  });
}
