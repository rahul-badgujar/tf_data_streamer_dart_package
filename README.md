# TfDataStreamer

This provides you with a base for streamer of data, which you can listen to.
Useful when you want to listen to the changes in certain data,
coming from a source e.g., API, Files, or from somewhere within the code and has probability of changes with time,
or requires reloading after certain events.
Provides useful data to alter data, filter data, add errors to the stream.

e.g., This data-streamer can be used to implement a filterable list, listen to the auth changes etc.>

## Supported Dart Versions

**Dart SDK version ">=2.12.0 <3.0.0"**

## Installation

Add the Package

```yaml
dependencies:
  tf_data_streamer: ^1.0.0
```

## How to use

Import the package in your dart file

```dart
import 'package:tf_data_streamer/tf_data_streamer.dart';
```

To implement the data streamer base for custom data events, simply extend the TfDataStreamer with template argument matching to the type of data you want to stream.
See example for more detailed use.

```dart
class AuthListener extends TfDataStreamer<AuthStatus> {
    // TODO: Implement the below method
    @override
    void reload() {
        // add your reload functionality here.
        // this method is expected to revalidate and refresh the event.
    }
}
```

Instantiate and initialize the Data Streamer (AuthListener in above case) before use.

```dart
final authStatusDataStreamer = AuthListener();
// the streamer can be made broadcast while initializing if multiple listeners would be there.
authStatusDataStreamer.init(broadcast: true);
```

Now you are good to operate and stream data. A good control over it.

```dart

// Push a new data update to the stream.
authStatusDataStreamer.addData(AuthStatus.signedIn);

// Push a error to the stream.
authStatusDataStreamer.addError(Exception('error'));

// Get access to data stream
final datastream = authStatusDataStreamer.stream;

// To get if stream is closed for data events
print(authStatusDataStreamer.isClosed);

// To get if stream is open for data events
print(authStatusDataStreamer.isOpen);

// To get if data-stream is broadcast stream or not
print(authStatusDataStreamer.isBroadcast);

// Listen to the events and errors from data streamer.
authStatusDataStreamer.stream.listen((event) {
    print('Auth Status Changed to $event');
}, onError: (error) {
    print('Failed to get latest Auth Status.');
});

// Dispose the data-streamer after use.
authStatusDataStreamer.dispose();

```
