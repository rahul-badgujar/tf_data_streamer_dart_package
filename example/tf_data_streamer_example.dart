import 'dart:async';
import 'dart:math';

import 'package:tf_data_streamer/tf_data_streamer.dart';

/// This example shows how the TfDataStreamer can be extended and implemented for an Auth Listener.

/// Represents various Auth Status
enum AuthStatus {
  signedIn,
  signedOut,
  notVerified,
  restricted,
}

/// Returns the AuthStatus from Server. The values are faked by randomly selecting any for example.
AuthStatus getFakeAuthStatusFromServer() {
  final authStatuses = AuthStatus.values;
  final index = Random().nextInt(authStatuses.length + 1);
  // error case
  if (index >= authStatuses.length) {
    throw Exception('Error');
  }
  return authStatuses[index];
}

/// The AuthListener Implementation
class AuthListener extends TfDataStreamer<AuthStatus> {
  // To store the current auth status, this data will be streamed.
  // The data being streamed should match the template argument type.
  late AuthStatus _currentAuthStatus;

  /// Getter for currentAuthStatus
  AuthStatus get currentAuthStatus {
    return _currentAuthStatus;
  }

  @override
  void reload() {
    try {
      // get the current auth status from server
      _currentAuthStatus = getFakeAuthStatusFromServer();
      // stream the new event for listeners to listen to
      addData(currentAuthStatus);
    } on Exception catch (e) {
      // in case of error, stream the error to listeners
      addError(e);
    }
  }
}

void main() {
  // Instantiate and initialize the AuthListener
  final authStatusListener = AuthListener();
  authStatusListener.init(broadcast: true);

  // Listen to the stream of data update events
  authStatusListener.stream.listen((event) {
    print('Auth Status Changed to $event');
  }, onError: (error) {
    print('Failed to get latest Auth Status.');
  });

  authStatusListener.addData(AuthStatus.signedIn);

  // For the instance, the server will be pinged every 3 seconds for latest auth status.
  // We can add data, add error, or reload() from anywhere in the code, and listeners will listen to it.
  Timer.periodic(Duration(seconds: 3), (timer) {
    authStatusListener.reload();
  });

  // To get if stream is closed for data events
  print(authStatusListener.isClosed);

  // To get if stream is open for data events
  print(authStatusListener.isOpen);

  // To get if data-stream is broadcast stream or not
  print(authStatusListener.isBroadcast);

  // Dispose the data-streamer after use.
  authStatusListener.dispose();
}
